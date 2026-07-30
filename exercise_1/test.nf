workflow {

    // Use Channel.fromPath(), splitCsv, map and tuple
    // The channel elements should look like: 
    // [<sample_name>, [<path_to_R1>, <path_to_R2>]]
    // The reads themselves should be a tuple within the tuple

    Channel.fromPath(params.samplesheet)
    | splitCsv (header: false)
    | map {row -> tuple(row[0], tuple(row[1], row[2]))}
    | view()


}