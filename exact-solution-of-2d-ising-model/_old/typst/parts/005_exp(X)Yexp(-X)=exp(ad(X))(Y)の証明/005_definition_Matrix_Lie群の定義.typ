#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition("Lie Groups, Lie Algebras, and Representations Definition 1.4")[
  $G subset bold("GL")(n, CC)$ で、以下の性質を満たす
  1. $G$は部分群
  2. $forall A_m : M(n, CC)"上収束する"G"の元の列" A := lim_(m->oo) A_m"とするとき、"A in G or A in.not bold("GL")(n, CC) $

  このとき、$G$を Matrix Lie群という
]

// #definition("Lie Groups, Lie Algebras, and Representations Definition 3.18")[
//   $G$ : Matrix Lie群について、

//   $frak(g) := {X in M(n, CC) | exp(t X) in G "for all" t in RR}$

//   $frak(g)$を$G$のLie環という
// ]

// #theorem([$frak(g)$が和と交換子で閉じていることの証明])[
//   TODO
// ]

// #definition([$G$と$frak(g)$の共通集合])[
//   $cal(G) subset M(n, CC)$を、
//   $
//   cal(G) := G sect frak(g)
//   $
//   と定める。
// ]
