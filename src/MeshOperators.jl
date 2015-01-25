module MeshOperators

type DifferentialOperators
    DifferentialOperators() = new()
    faceDiv::SparseMatrixCSC
    nodalGrad::SparseMatrixCSC
    edgeCurl::SparseMatrixCSC
end

end
