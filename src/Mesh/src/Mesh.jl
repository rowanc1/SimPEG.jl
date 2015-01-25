module Mesh

abstract SimpegMesh
abstract SimpegMesh1D <: SimpegMesh
abstract SimpegMesh2D <: SimpegMesh
abstract SimpegMesh3D <: SimpegMesh

import MeshCount

type TensorMesh1D <: SimpegMesh2D
    hx::Vector{Float64}
    x0::Vector{Float64}
    cnt::MeshCount.TensorMesh1DCounters
    TensorMesh1D(hx, x0) = new(hx, x0, MeshCount.countTensorMesh([length(hx)]))
    vol::Vector{Float64}
    area::Vector{Float64}
    edge::Vector{Float64}
end

type TensorMesh2D <: SimpegMesh2D
    hx::Vector{Float64}
    hy::Vector{Float64}
    x0::Vector{Float64}
    cnt::MeshCount.TensorMesh2DCounters
    TensorMesh2D(hx, hy, x0) = new(hx, hy, x0, MeshCount.countTensorMesh([length(hx), length(hy)]))
    vol::Vector{Float64}
    area::Vector{Float64}
    edge::Vector{Float64}
end

type TensorMesh3D <: SimpegMesh3D
    hx::Vector{Float64}
    hy::Vector{Float64}
    hz::Vector{Float64}
    x0::Vector{Float64}
    cnt::MeshCount.TensorMesh3DCounters
    TensorMesh3D(hx, hy, hz, x0) = new(hx, hy, hz, x0, MeshCount.countTensorMesh([length(hx), length(hy), length(hz)]))
    vol::Vector{Float64}
    area::Vector{Float64}
    edge::Vector{Float64}
end

function TensorMesh(hx::Vector{Float64}; x0=zeros(1))
    M = TensorMesh1D(hx, x0)
    M.vol = hx
    M.area = ones(M.cnt.nN)
    M.edge = hx
    return M
end

function TensorMesh(hx::Vector{Float64},hy::Vector{Float64}; x0=zeros(2))
    M = TensorMesh2D(hx, hy, x0)
    M.vol  = (hx * hy')[:]
    M.area = [
                (ones(M.cnt.nNx) * hy')[:],
                (hx * ones(M.cnt.nNy)')[:]
             ]
    M.edge = [
                (hx * ones(M.cnt.nNy)')[:],
                (ones(M.cnt.nNx) * hy')[:]
             ]
    return M
end

function TensorMesh(hx::Vector{Float64},hy::Vector{Float64},hz::Vector{Float64}; x0=zeros(3))

    # area1 = outer(ones(n[0]+1), Utils.mkvc(outer(vh[1], vh[2])))
    # area2 = outer(vh[0], Utils.mkvc(outer(ones(n[1]+1), vh[2])))
    # area3 = outer(vh[0], Utils.mkvc(outer(vh[1], ones(n[2]+1))))
    M = TensorMesh3D(hx, hy, hz, x0)
    M.vol = ((hx * hy')[:] * hz')[:]
    M.area = [
                ( ones(M.cnt.nNx) * ( hy * hz' )[:]' )[:],
                ( hx * ( ones(M.cnt.nNy) * hz' )[:]' )[:],
                ( hx * ( hy * ones(M.cnt.nNz)' )[:]' )[:]
             ]
    M.edge = [
                ( hx * ( ones(M.cnt.nNy) * ones(M.cnt.nNz)' )[:]' )[:],
                ( ones(M.cnt.nNx) * ( hy * ones(M.cnt.nNz)' )[:]' )[:],
                ( ones(M.cnt.nNx) * ( ones(M.cnt.nNy) * hz' )[:]' )[:]
             ]
    return M
end

hx = ones(1)
hy = ones(2)
hz = ones(3)

M = TensorMesh(hx, hy, hz)
println(M)
println(M.cnt.nF)

end
