function get_interp(final_particles, primary_channel)
    # return interpolation for Log10[dN/dLog10(x)]
    mDM, Log10x = get_mDM_Log10x(final_particles)
    data_ = read_data(final_particles, primary_channel)
    data = reshape(data_, length(Log10x), length(mDM))
    # make a linear interpolation, extrapolate in the first dimension with 0 and in the second dimension by throwing an error

    itp = linear_interpolation((Log10x, log10.(mDM)), data, extrapolation_bc = 0)
    return itp
end


@memoize function get_dNdx(final_particles, primary_channel)
    itp = get_interp(final_particles, primary_channel)
    function dNdx(mDM_::Energy, x::Real)
        mDM = ustrip(u"GeV", mDM_)
        @assert 5<=mDM<=5000 "mDM must be between 5 GeV and 5000 GeV"
        return itp(log10(x), log10(mDM))
    end
    return dNdx
end

@memoize function get_dNdE(final_particles, primary_channel)
    itp = get_interp(final_particles, primary_channel)
    function dNdE(mDM::Energy, K::Energy)
        x = K / mDM
        @assert 5u"GeV"<=mDM<=5000u"GeV" "mDM must be between 5 GeV and 5000 GeV"
        return 1 / mDM * itp(log10(x), log10(ustrip(u"GeV", mDM)))
    end
    return dNdE
end

"""
    dNdE(mDM::Energy, K::Energy; final_particles="Gammas", primary_channel="b")

Return the differential flux of `final_particles` from the annihilation of dark matter into `primary_channel` particles, 
given the energy of final particles `K` and the dark matter mass `mDM`.

Available `final_particles` are: `AntiProtons`, `Gammas`, `NuEl`, `NuMu`, `NuTau`, `Positrons`.

Available `primary_channel` are: 
- `eL`, `eR`, `e`,
- `muL`, `muR`, `mu`,
- `tauL`, `tauR`, `tau`,
- `nu_e`, `nu_mu`, `nu_tau`,
- `u`, `d`, `s`, `c`, `b`, `t`,
- `a`, `g`,
- `W`, `WL`, `WT`,
- `Z`, `ZL`, `ZT`,
- `H`,
- `aZ`,
- `HZ`

"""
function dNdE(mDM::Energy, K::Energy; final_particles="Gammas", primary_channel="b")
    if K > mDM
        return zero(Float64) * u"GeV^-1"
    else
        return get_dNdE(final_particles, primary_channel)(mDM, K)
    end
end