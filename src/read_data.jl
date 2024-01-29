function read_data(final_particles)
    fname = "$(@__DIR__)/Data/AtProduction-" * final_particles * ".dat"
    file_content = read(fname, String)
    modified_content = replace(file_content, "\t" => " ")
    data = CSV.File(IOBuffer(modified_content), delim=' ', header=column_names, ignorerepeated=true, skipto=2) |> DataFrame
    return data
end


function read_data(final_particles, primary_channel)
    data = read_data(final_particles)
    return data[!, primary_channel]
end

function get_mDM_Log10x(final_particles)
    data = read_data(final_particles)
    mDM = unique(data[!, "mDM"])
    Log10x = unique(data[!, "Log10(x)"])
    return mDM, Log10x
end