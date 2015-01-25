module MeshOperators

type DifferentialOperators
    DifferentialOperators() = new()
    faceDiv::SparseMatrixCSC
    nodalGrad::SparseMatrixCSC
    edgeCurl::SparseMatrixCSC
    aveF2CC::SparseMatrixCSC
    aveF2CCV::SparseMatrixCSC
    aveCC2F::SparseMatrixCSC
    aveE2CC::SparseMatrixCSC
    aveE2CCV::SparseMatrixCSC
    aveN2CC::SparseMatrixCSC
    aveN2E::SparseMatrixCSC
    aveN2F::SparseMatrixCSC
end

end
