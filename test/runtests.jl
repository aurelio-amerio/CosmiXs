using CosmiXs
using Test
using Unitful


for final_particle in CosmiXs.final_particles
    @testset "dNdE $final_particle" begin
        for primary_channel in CosmiXs.primary_channels
            data_ = CosmiXs.read_data(final_particle, primary_channel)
            mDM, Log10x = CosmiXs.get_mDM_Log10x(final_particle)
            data = reshape(data_, length(Log10x), length(mDM))

            idx_mDM = 42
            idx_Log10x = 42
            mDM_val = mDM[idx_mDM]
            Log10x_val = Log10x[idx_Log10x]
            x_val = 10^Log10x_val
            K_val = mDM_val*x_val
            
            dNdE_value = data[idx_Log10x, idx_mDM]/(K_val*log(10))*u"GeV^-1"
            
            @test dNdE(mDM_val*u"GeV", K_val*u"GeV"; final_particles=final_particle, primary_channel=primary_channel) ≈ dNdE_value

            @test dNdE(mDM_val*u"GeV", mDM_val*u"GeV"; final_particles=final_particle, primary_channel=primary_channel) ≈ 0u"GeV^-1"
            
            @test dNdE(mDM_val*u"GeV", 2*mDM_val*u"GeV"; final_particles=final_particle, primary_channel=primary_channel) ≈ 0u"GeV^-1"

            @test_throws AssertionError dNdE(1u"GeV", K_val*u"GeV"; final_particles=final_particle, primary_channel=primary_channel)
        end
    end
end

