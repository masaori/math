# 共役写像は環準同型 — 必要十分版で何が効いていたか

対象の人手証明: `<conjugation_is_ring_homomorphism>`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の
`calculation_formulae_046_claim_conjugation_is_ring_homomorphism`、
原文は `_old/typst/parts/000_計算公式/045_claim_共役写像は環準同型.typ`）。

| | ファイル | 主要な宣言 |
| --- | --- | --- |
| 具体版（人手証明と 1 対 1） | `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean` | `Ising2D.Conjugation.matrix_conj_mul` / `matrix_conj_one` / `matrix_conj_comp` |
| 必要十分版 | `Ising2D/NecSuf/Conjugation.lean` | `Ising2D.NecSuf.Conj.sandwich_mul` / `sandwich_one` / `sandwich_comp` / `sandwich_add` / `conjMulAutHom` |
| 必要十分版からの導出 | `Ising2D/Part000/Claim045_ConjugationIsRingHomFromNecSuf.lean` | `Ising2D.Conjugation.matrix_conj_mul_of_necSuf` ほか |

以下はすべて Lean で通っている証明（`lake build` と `scripts/check-no-sorry.sh` が通る状態）に
基づく記述であり、見込みや推測ではない。

## 1. 「環」は要らない — (1)(2)(3) はモノイドで足りる

原文は主張の名前からして「環準同型」だが、原文が実際に述べている 3 つの性質

1. 乗法性 `T_B(AC) = T_B(A) T_B(C)`
2. 単位性 `T_B(I) = I`
3. 合成則 `T_A ∘ T_B = T_{AB}`

の証明に、**加法も分配法則も一度も現れない**。必要十分版ではこれらを
`Semigroup`（結合律のみ）と `Monoid`（結合律＋単位元）の上で証明してあり、
環の構造を仮定していない（`Conj.sandwich_comp`, `Conj.sandwich_mul`, `Conj.sandwich_one`）。

分配法則が要るのは**加法性だけ**である（`Conj.sandwich_add`、仮定は `Semiring`）。
つまり原文の主張名にある「環」は、原文が明示していない加法性を含めて初めて必要になる。
さらに言えば `Semiring` で足り、減法（`Ring`）は使っていない。

行列であること・複素数であること・有限次元であること・`n ≥ 1` は、
どの性質にも効いていない。

## 2. 可逆性が効く箇所と効かない箇所

必要十分版では、逆元をあらかじめ固定せずに「挟み込み写像」

```
sandwich b u : a ↦ b * a * u
```

を定義し、各性質に必要な `b, u` の関係だけを仮定として書いた。結果は次のとおり。

| 性質 | 必要な代数構造 | `b, u` に必要な関係 |
| --- | --- | --- |
| 合成則 (3) | 半群（結合律のみ） | **不要** |
| 乗法性 (1) | モノイド | `u * b = 1`（**左**逆元のみ） |
| 単位性 (2) | モノイド | `b * u = 1`（**右**逆元のみ） |
| 加法性 | 半環（分配法則） | **不要** |
| 全単射（自己同型であること） | モノイド | 両側（真の可逆性） |

要点は 2 つある。

- **合成則 (3) には可逆性が一切効いていない。** `a (b x b') a' = (ab) x (b'a')` は結合律だけで
  成り立つ（`Conj.sandwich_comp` は仮定なしの定理）。原文 Step 3 が `(AB)^{-1} = B^{-1}A^{-1}` を
  わざわざ確認しているのは、右側に出る `B^{-1}A^{-1}` を `(AB)^{-1}` と**書き直す**ためであって、
  合成則そのものの証明ではない。行列側の導出 `matrix_conj_comp_of_necSuf` でも、
  足しているのは `Matrix.mul_inv_rev` による書き直しの 1 行だけである。
- **乗法性と単位性は、可逆性の別々の半分しか使っていない。** 乗法性が使うのは真ん中で
  `u * b` が消えること（左逆元）、単位性が使うのは `b * u` が消えること（右逆元）である。
  原文が「`B` は正則」と一括で仮定しているものは、性質ごとに片側ずつに分解できる。

片側では足りないことは、散文の主張ではなく Lean の反例として置いてある
（`Conj.sandwich_mul_needs_left_inv` / `Conj.sandwich_one_needs_right_inv`）。
台はモノイド `Function.End ℕ`（写像の合成を積とする）で、`b` を「1 引く」、`u` を「1 足す」と
取ると `b * u = 1` だが `u * b ≠ 1` であり、実際に乗法性が破れる組
（`a : n ↦ 2n`, `c : n ↦ 0`）が存在する。左右を入れ替えると今度は単位性が破れる。
行列環のような有限次元代数では片側逆元が両側逆元になってしまうため、この分離は
**行列を離れて初めて見える**。原文の「正則」という仮定が過剰かどうかを判定するには
抽象化が必要だった、ということでもある。

## 3. 合成則 (3) の正体は「群準同型」

原文は (3) を `T_A ∘ T_B = T_{AB}` という等式として述べているが、必要十分版ではこれを

```
Ising2D.NecSuf.Conj.conjMulAutHom : Mˣ →* MulAut M
```

すなわち**単元群からモノイド自己同型群への群準同型**という 1 つの主張に集約した。
(3) はこの `map_mul` そのものである（各点版は `Conj.conjMonoidHom_comp`）。
半環に上げた版が `Conj.conjRingAutHom : Rˣ →* RingAut R`、
それを行列へ特殊化したものが `Ising2D.Conjugation.matrixConjRingAutHom` である。

この見方をとると、原文が (3) の証明で確認している `(AB)^{-1} = B^{-1}A^{-1}` は
`Units` の逆元がもともと満たしている性質に吸収され、独立の補題として立てる必要がなくなる。

## 4. 具体版が過剰な構造を要求していないかの検査

具体版（`matrix_conj_mul` / `matrix_conj_one` / `matrix_conj_comp`）は、必要十分版の系として
そのまま得られた（`matrix_conj_mul_of_necSuf` / `matrix_conj_one_of_necSuf` /
`matrix_conj_comp_of_necSuf`）。行列側で追加した事実は

- `Matrix.nonsing_inv_mul B hB : B⁻¹ * B = 1`（乗法性用）
- `Matrix.mul_nonsing_inv B hB : B * B⁻¹ = 1`（単位性用）
- `Matrix.mul_inv_rev`（合成則の書き直し用。正則性不要）

の 3 つだけであり、成分計算・行列式・次元は使っていない。
したがって具体版は過剰な構造を要求していない。

なお既存の具体版ファイルにある一般環版 `Ising2D.Conjugation.T` は、必要十分版の
`Conj.conjMonoidHom` と**定義的に等しい**（`Ising2D.Conjugation.T_eq_conjMonoidHom` は `rfl`）。
既存の具体版は mathlib の `ConjAct` 経由で加法性まで一括に得ていたが、その経路では
「どの性質にどの仮定が効いているか」が `MulSemiringAction` インスタンスの中に隠れる。
必要十分版はそこを開いて、仮定ごとに分けた形で置き直したものである。

## 5. 本文（人手証明）へは持ち込まない

`exact-solution-of-2d-ising-model/README.md` 4 節の規約どおり、必要十分版は Lean の中だけに置く。
上記の知見を book/論文で述べるなら、抽象的な語彙（モノイド・単元群・自己同型群）ではなく
「この計算に使っているのは行列の積の結合法則と `B^{-1}B = I`（乗法性）、`BB^{-1} = I`（単位性）だけで、
成分の形も次数も使っていない」という具体的な言い方へ書き直すこと。
