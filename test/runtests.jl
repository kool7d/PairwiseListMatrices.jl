using PairwiseListMatrices
using Base.Test

print("""

Test PairwiseListMatrices
=======================
""")

let list = [1,-2,3],
    list_diag_triu =  [ 1 -2
                        0 3 ],
    list_diag_tril =  [ 1 0
                       -2 3 ],
    list_triu = [ 0 1 -2
                  0 0 3
                  0 0 0 ],
    list_tril = [ 0 0 0
                  1 0 0
                 -2 3 0 ],
    list_diag_sym = [ 1 -2
                     -2 3 ],
    list_sym = [ 0 1 -2
                 1 0 3
                -2 3 0 ]

  print("""

  Test creations from list
  ------------------------
  """)

  pld_triu = UpperTriangular(PairwiseListMatrix(list, true))
  pld_tril = LowerTriangular(PairwiseListMatrix(list, true))
  pl_triu  = UpperTriangular(PairwiseListMatrix(list))
  pl_tril  = LowerTriangular(PairwiseListMatrix(list))
  pld_sym  = PairwiseListMatrix(list, true)
  pl_sym   = PairwiseListMatrix(list)

  @test pld_triu == list_diag_triu
  @test pld_tril == list_diag_tril
  @test pl_triu  == list_triu
  @test pl_tril  == list_tril
  @test pld_sym  == list_diag_sym
  @test pl_sym   == list_sym

  print("""

  Test unary operations
  ---------------------
  """)

  @test -pld_triu == -list_diag_triu
  @test -pld_tril == -list_diag_tril
  @test -pl_triu  == -list_triu
  @test -pl_tril  == -list_tril
  @test -pld_sym  == -list_diag_sym
  @test -pl_sym   == -list_sym

  @test abs(pld_triu) == abs(list_diag_triu)
  @test abs(pld_tril) == abs(list_diag_tril)
  @test abs(pl_triu ) == abs(list_triu)
  @test abs(pl_tril ) == abs(list_tril)
  @test abs(pld_sym ) == abs(list_diag_sym)
  @test abs(pl_sym  ) == abs(list_sym)

  print("""

  Test binary operations
  ----------------------
  """)

  @test pld_triu - pld_triu == list_diag_triu - list_diag_triu
  @test pld_tril - pld_tril == list_diag_tril - list_diag_tril
  @test pl_triu  - pl_triu  == list_triu - list_triu
  @test pl_tril  - pl_tril  == list_tril - list_tril
  @test pld_sym  - pld_sym  == list_diag_sym - list_diag_sym
  @test pl_sym   - pl_sym   == list_sym - list_sym

  @test pld_triu + pld_triu == list_diag_triu + list_diag_triu
  @test pld_tril + pld_tril == list_diag_tril + list_diag_tril
  @test pl_triu  + pl_triu  == list_triu + list_triu
  @test pl_tril  + pl_tril  == list_tril + list_tril
  @test pld_sym  + pld_sym  == list_diag_sym + list_diag_sym
  @test pl_sym   + pl_sym   == list_sym + list_sym

  @test pld_triu .* pld_triu == list_diag_triu .* list_diag_triu
  @test pld_tril .* pld_tril == list_diag_tril .* list_diag_tril
  @test pl_triu  .* pl_triu  == list_triu .* list_triu
  @test pl_tril  .* pl_tril  == list_tril .* list_tril
  @test pld_sym  .* pld_sym  == list_diag_sym .* list_diag_sym
  @test pl_sym   .* pl_sym   == list_sym .* list_sym

  print("""

  Transpose
  ---------
  """)

  @test transpose(pld_triu) == pld_tril == list_diag_triu.'
  @test transpose(pld_tril) == pld_triu == list_diag_tril.'
  @test transpose(pl_triu) == pl_tril == list_triu.'
  @test transpose(pl_tril) == pl_triu == list_tril.'

  @test ctranspose(pld_triu) == pld_tril == list_diag_triu'
  @test ctranspose(pld_tril) == pld_triu == list_diag_tril'
  @test ctranspose(pl_triu) == pl_tril == list_triu'
  @test ctranspose(pl_tril) == pl_triu == list_tril'

  @test transpose(pld_sym) == pld_sym == list_diag_sym.'
  @test transpose(pl_sym) == pl_sym == list_sym.'

  @test ctranspose(pld_sym) == pld_sym == list_diag_sym'
  @test ctranspose(pl_sym) == pl_sym == list_sym'

  @test transpose!(pl_sym) == pl_sym
  @test ctranspose!(pl_sym) == pl_sym

  print("""

  Linear algebra
  --------------
  """)

  @test pld_triu * pld_triu == list_diag_triu * list_diag_triu
  @test pld_tril * pld_tril == list_diag_tril * list_diag_tril
  @test pl_triu  * pl_triu  == list_triu      * list_triu
  @test pl_tril  * pl_tril  == list_tril      * list_tril
  @test pld_sym  * pld_sym  == list_diag_sym  * list_diag_sym
  @test pl_sym   * pl_sym   == list_sym       * list_sym
  @test Symmetric(pl_sym) * Symmetric(pl_sym) == Symmetric(list_sym) * Symmetric(list_sym)

  @test pld_triu / pld_triu == list_diag_triu / list_diag_triu
  @test pld_tril / pld_tril == list_diag_tril / list_diag_tril
  @test pld_sym  / pld_sym  == list_diag_sym  / list_diag_sym
  @test pl_sym   / pl_sym   == list_sym       / list_sym

  @test svd(pld_triu) == svd(list_diag_triu)
  @test svd(pld_tril) == svd(list_diag_tril)
  @test svd(pl_triu ) == svd(list_triu)
  @test svd(pl_tril ) == svd(list_tril)
  @test svd(pld_sym ) == svd(list_diag_sym)
  @test svd(pl_sym  ) == svd(list_sym)

  print("""

  Stats
  -----
  """)

  @test mean(pld_triu) == mean(list_diag_triu)
  @test mean(pld_tril) == mean(list_diag_tril)
  @test mean(pl_triu ) == mean(list_triu)
  @test mean(pl_tril ) == mean(list_tril)
  @test mean(pld_sym ) == mean(list_diag_sym)
  @test mean(pl_sym  ) == mean(list_sym)

  @test mean(pld_sym,1) == mean(list_diag_sym, 1)
  @test mean(pl_sym ,1) == mean(list_sym, 1)

  @test mean(pld_sym,2) == mean(list_diag_sym, 2)
  @test mean(pl_sym ,2) == mean(list_sym, 2)

  @test std(pld_triu) == std(list_diag_triu)
  @test std(pld_tril) == std(list_diag_tril)
  @test std(pl_triu ) == std(list_triu)
  @test std(pl_tril ) == std(list_tril)
  @test std(pld_sym ) == std(list_diag_sym)
  @test std(pl_sym  ) == std(list_sym)

  @test std(pld_sym,1) == std(list_diag_sym, 1)
  @test std(pl_sym, 1) == std(list_sym, 1)

  @test std(pld_sym,2) == std(list_diag_sym, 2)
  @test std(pl_sym, 2) == std(list_sym, 2)


#  @test cor(pld_triu) == cor(list_diag_triu)
#  @test cor(pld_tril) == cor(list_diag_tril)
#  @test cor(pl_triu ) == cor(list_triu)
#  @test cor(pl_tril ) == cor(list_tril)
  @test cor(pld_sym ) == cor(list_diag_sym)
  @test cor(pl_sym  ) == cor(list_sym)

end

print("""

List with Labels
----------------
""")

let list = [1,2,3], labels=['a', 'b', 'c'], labels_diag = ['A', 'B'],
    list_diag_triu =  UpperTriangular(PairwiseListMatrix(list, labels_diag, true)),
    list_diag_tril =  LowerTriangular(PairwiseListMatrix(list, labels_diag, true)),
    list_triu = UpperTriangular(PairwiseListMatrix(list, labels)),
    list_tril = LowerTriangular(PairwiseListMatrix(list, labels)),
    list_diag_sym = PairwiseListMatrix(list, labels_diag, true),
    list_sym = PairwiseListMatrix(list, labels)

  print("""
  labels(!) & copy
  """)

  @test PairwiseListMatrices.labels(list_diag_sym) == labels_diag

  copy_lm = copy(list_sym)
  labels!(copy_lm, ['A', 'B', 'C'])
  @test PairwiseListMatrices.labels(copy_lm) == ['A', 'B', 'C']

  @test PairwiseListMatrices.labels(list_sym) == labels

  @test diag(list_diag_sym) == [1, 3]
  @test diag(list_sym) == [0, 0, 0]

  print("""
  getlabel & getindex
  """)

  @test getlabel(list_diag_sym, 'A', 'B') == list_diag_sym[1,2] == 2
  @test getlabel(list_diag_sym, 'B', 'A') == list_diag_sym[2,1] == 2

  @test getlabel(list_sym, 'a', 'b') == list_sym[1,2] == 1
  @test getlabel(list_sym, 'b', 'a') == list_sym[2,1] == 1

  print("""
  setlabel! & setindex!
  """)

  setlabel!(list_diag_sym, 20, 'A', 'B')
  @test list_diag_sym[1,2] == 20
  setlabel!(list_diag_sym, 10, 'B', 'A')
  @test list_diag_sym[2,1] == 10

  setlabel!(list_sym, 20, 'a', 'b')
  @test list_sym[1,2] == 20
  setlabel!(list_sym, 10, 'b', 'a')
  @test list_sym[2,1] == 10

  list_diag_sym[1,2] = 10
  @test list_diag_sym[2,1] == 10

  list_sym[1,2] = 10
  @test list_sym[2,1] == 10

end
