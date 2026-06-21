#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$V = c V'$ (定数倍を除いて一致)])[
  ある$c in CC^(times)$が存在して、

  $
    V = c dot.op V'
  $

  ここで $V := (V_1^((plus.minus)))^(1/2) V_2 (V_1^((plus.minus)))^(1/2)$（$#ref(<def_T_V>)$ で導入され、$#ref(<T_V_eq_T_Vprime>)$ の Step 1 で $T_((V)) = T_(V)$ が示された行列）とする。

  #note[
    この証明はクリフォード群（$#ref(<def_T_g>)$ とは別の TODO 項目 009）の性質には依存しない。$#ref(<T_V_eq_T_Vprime>)$ の共役写像としての一致から、全行列環 $"Mat"(2, CC)^(times.o M)$ の中心がスカラーに限ること（$#ref(<centralizer_is_scalar>)$）を用いて結論する。
  ]

  #proof[
    === Step 1: $W := V'^(-1) V$ は可逆である

    $#ref(<T_V_eq_T_Vprime>)$ の Step 1 より、$V := (V_1^((plus.minus)))^(1/2) V_2 (V_1^((plus.minus)))^(1/2)$ は可逆である。また $#ref(<def_Vprime>)$ より $V'$ は可逆であり、可逆行列の逆行列 $V'^(-1)$ も可逆である。

    $
      W := V'^(-1) V
    $
    とおく。可逆行列の積は可逆であるから $W$ は可逆である。特に $W$ の逆行列 $W^(-1)$ が存在する。

    左から $V'$ を掛けると
    $
      V' W
      &=
      V' (V'^(-1) V)
      quad (because W = V'^(-1) V)
      \
      &=
      (V' V'^(-1)) V
      quad (because "行列の積の結合法則")
      \
      &=
      I_(("Mat"(2, CC))^(times.o M)) V
      quad (because V' V'^(-1) = I_(("Mat"(2, CC))^(times.o M)))
      \
      &=
      V
      quad (because "単位元の性質")
    $
    すなわち
    $
      V = V' W
    $
    を得る。

    === Step 2: $W$ はすべての $x in "Mat"(2, CC)^(times.o M)$ と可換である

    $#ref(<T_V_eq_T_Vprime>)$ より $T_((V)) = T_((V'))$ であり、$#ref(<T_V_eq_T_Vprime>)$ の Step 1 で示された $T_((V)) = T_(V)$ と合わせると、任意の $x in "Mat"(2, CC)^(times.o M)$ について
    $
      T_(V)(x)
      &=
      T_((V))(x)
      quad (because #ref(<T_V_eq_T_Vprime>) "の Step 1: " T_((V)) = T_(V))
      \
      &=
      T_((V'))(x)
      quad (because #ref(<T_V_eq_T_Vprime>): T_((V)) = T_((V')))
    $
    が成り立つ。両辺を $#ref(<mat_conj>)$ の共役写像の定義で書き下すと、任意の $x$ について
    $
      V x V^(-1)
      &=
      T_(V)(x)
      quad (because #ref(<mat_conj>))
      \
      &=
      T_((V'))(x)
      quad (because "上の等式")
      \
      &=
      V' x V'^(-1)
      quad (because #ref(<mat_conj>))
    $
    すなわち
    $
      V x V^(-1) = V' x V'^(-1)
    $
    である。

    ここで Step 1 の $V = V' W$ を代入する。まず逆行列について、$#ref(<conjugation_is_ring_homomorphism>)$ の Step 3 で確認された積の逆元の公式 $(A B)^(-1) = B^(-1) A^(-1)$ より
    $
      V^(-1)
      &=
      (V' W)^(-1)
      quad (because V = V' W)
      \
      &=
      W^(-1) V'^(-1)
      quad (because (A B)^(-1) = B^(-1) A^(-1))
    $
    が成り立つ。これらを上の等式 $V x V^(-1) = V' x V'^(-1)$ の左辺に代入すると、任意の $x$ について
    $
      V' (W x W^(-1)) V'^(-1)
      &=
      (V' W) x (W^(-1) V'^(-1))
      quad (because "行列の積の結合法則")
      \
      &=
      V x V^(-1)
      quad (because V = V' W "、" V^(-1) = W^(-1) V'^(-1))
      \
      &=
      V' x V'^(-1)
      quad (because V x V^(-1) = V' x V'^(-1))
    $
    が成り立つ。両辺に左から $V'^(-1)$、右から $V'$ を掛けると、任意の $x$ について
    $
      W x W^(-1)
      &=
      V'^(-1) (V' (W x W^(-1)) V'^(-1)) V'
      quad (because V'^(-1) V' = V' V'^(-1) = I_(("Mat"(2, CC))^(times.o M)))
      \
      &=
      V'^(-1) (V' x V'^(-1)) V'
      quad (because V' (W x W^(-1)) V'^(-1) = V' x V'^(-1))
      \
      &=
      x
      quad (because V'^(-1) V' = V' V'^(-1) = I_(("Mat"(2, CC))^(times.o M)))
    $
    すなわち $W x W^(-1) = x$ である。両辺に右から $W$ を掛けると、任意の $x in "Mat"(2, CC)^(times.o M)$ について
    $
      W x
      &=
      (W x W^(-1)) W
      quad (because W^(-1) W = I_(("Mat"(2, CC))^(times.o M)))
      \
      &=
      x W
      quad (because W x W^(-1) = x)
    $
    が成り立つ。したがって $W$ はすべての $x in "Mat"(2, CC)^(times.o M)$ と可換である。

    === Step 3: $W$ はスカラーである

    Step 2 より $W$ はすべての $x in "Mat"(2, CC)^(times.o M)$ と可換であるから、$#ref(<centralizer_is_scalar>)$ より、ある $c in CC$ が存在して
    $
      W = c dot.op I_(("Mat"(2, CC))^(times.o M))
      quad (because #ref(<centralizer_is_scalar>))
    $
    が成り立つ。

    === Step 4: $c != 0$ であること

    Step 1 より $W$ は可逆である。仮に $c = 0$ ならば $W = 0 dot.op I_(("Mat"(2, CC))^(times.o M)) = O$（零行列）となるが、零行列は可逆でない（任意の $A$ について $O A = O != I_(("Mat"(2, CC))^(times.o M))$）から、$W$ が可逆であることに矛盾する。よって $c != 0$、すなわち $c in CC^(times)$ である。

    === Step 5: 結論

    Step 1 の $V = V' W$ に Step 3 の $W = c dot.op I_(("Mat"(2, CC))^(times.o M))$ を代入すると
    $
      V
      &=
      V' W
      quad (because "Step 1")
      \
      &=
      V' (c dot.op I_(("Mat"(2, CC))^(times.o M)))
      quad (because "Step 3")
      \
      &=
      c dot.op (V' I_(("Mat"(2, CC))^(times.o M)))
      quad (because "スカラー倍と行列積の可換性")
      \
      &=
      c dot.op V'
      quad (because "単位元の性質")
    $
    が成り立つ。Step 4 より $c in CC^(times)$ であるから、求める $c in CC^(times)$ が存在して $V = c dot.op V'$ である。

    $qed$
  ]
]<V_eq_Vprime>
