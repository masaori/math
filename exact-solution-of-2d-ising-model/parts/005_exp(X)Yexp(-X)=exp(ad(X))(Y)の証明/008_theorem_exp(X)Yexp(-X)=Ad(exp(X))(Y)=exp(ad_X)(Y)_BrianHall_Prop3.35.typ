#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("Lie Groups, Lie Algebras, and Representations Proposition 3.35")[
  // $forall X in frak(g), forall Y in cal(G)$
  $forall X in M(n, CC) s.t. (forall t in RR exp(t X) in G), forall Y in G$

  $
  exp(X) Y exp(-X) = op("Ad")_(exp(X))(Y) = exp(op("ad")_X)(Y)
  $

  #note[
    この定理は "Lie Groups, Lie Algebras, and Representations"（Brian Hall）Proposition 3.35 の参考記述であり、このリポジトリでは未証明である。証明の根拠として使用することは禁止する。
  ]
]<brianhall_3.35>

TODO: 一旦 $e^(X) Y e^(-X) = e^("ad"(X))(Y)$ (@brianhall_3.35) の証明は後回して、これが成り立ってるとして計算がどう進むかを見てみる
