# 抽象版で判明した「何が本質か」 — `<conjugation_is_ring_homomorphism>`（共役写像は環準同型）

対象の人手証明: `structured-latex/content/000_calculation_formulae_45_46.ts` の
`conjugation_is_ring_homomorphism`（原文 `_old/typst/parts/000_計算公式/045_claim_共役写像は環準同型.typ`）。

| | ファイル | 主要な宣言 |
| --- | --- | --- |
| 抽象版 | `Ising2D/Abstract/Conjugation.lean` | `Abstract.sandwich_sandwich` / `sandwich_mul_of_left_inv` / `sandwich_one_of_right_inv` / `sandwich_add` / `conj_mul` / `conj_one` / `conj_conj` / `conjAut` / `conjRingHom` / `conjRingAut` |
| 具体版（原文と同じ形の直接証明） | `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean`（既存・未改変） | `Conjugation.matrix_conj_mul` / `matrix_conj_one` / `matrix_conj_comp` |
| 具体版（抽象版の系として導出） | `Ising2D/Part000/Claim045_ConjugationIsRingHomAbstract.lean` | `matrix_conj_mul_of_abstract` / `matrix_conj_one_of_abstract` / `matrix_conj_comp_of_abstract` / `matrix_conj_add_of_abstract` / `matrixConjRingHom` / `matrixConjRingHom_comp` |

原文の主張は、正則な `B ∈ Mat(n,ℂ)` に対する `T_B(A) = B A B⁻¹` が
(1) 乗法的 (2) 単位的 (3) 合成則 `T_A ∘ T_B = T_{AB}` を満たす、というものである。

## 効いている構造

抽象版では、逆元も単位元も持たない段階で `sandwich b u a = b * a * u`（両側から挟む写像）を定義し、
原文の各ステップがどの仮定で通るかを型クラスで切り分けた。結果は次のとおり。

| 原文のステップ | 通すのに必要な仮定（Lean で確認済み） | 対応する定理 |
| --- | --- | --- |
| (1) 乗法性 | 結合法則 ＋ **右因子が `b` の左逆元であること `u b = 1` だけ** | `Abstract.sandwich_mul_of_left_inv` |
| (2) 単位性 | 単位元 ＋ **右因子が `b` の右逆元であること `b u = 1` だけ** | `Abstract.sandwich_one_of_right_inv` |
| (3) 合成則 | **結合法則だけ**（`Semigroup`。逆元・単位元は不要） | `Abstract.sandwich_sandwich` |
| 加法性（原文は明示していないが「環準同型」に必要） | **分配法則だけ**（可逆性も結合法則も単位元も不要） | `Abstract.sandwich_add` |

すなわち、原文の (1)(2)(3) を単元 `b : Mˣ` の共役写像として述べるのに必要なのは
**モノイドとその単元群だけ**であり（`Abstract.conj_mul` / `conj_one` / `conj_conj`）、
環であることが効いているのは加法性の 1 点だけである。

(3) の内容は「`b ↦ T_b` が単元群 `Mˣ` からモノイド自己同型群 `MulAut M` への**群準同型**である」
ことに集約される（`Abstract.conjAut`）。環の場合はこれに加法性が付いて
`Rˣ →* RingAut R` になる（`Abstract.conjRingAut`）。

## 効いていなかったもの

原文の書きぶりが要求しているように見えて、実際には証明に効いていないもの:

- **行列であること。** どの主張も行列の成分・添字を使わない。台はモノイド（加法性では
  分配法則を持つ構造）であればよい。
- **成分が複素数であること。** 係数体・可換性・標数はどこにも効かない。
- **次数 `n` が有限であること、添字型が等号判定可能であること。** 具体版でこれらが要るのは
  `Matrix.inv` を定義するためだけであり、主張の中身には効かない。
- **環であること（加法の存在）。** (1)(2)(3) には加法が一切現れない。原文が「環準同型」と
  名づけているうち、環の加法が効くのは加法性だけである。
- **逆元の両側性。** (1) は左逆元しか使わず、(2) は右逆元しか使わない。原文 Step 1 が
  `B⁻¹B = I` を、Step 2 が `BB⁻¹ = I` を使っているのは、まさにこの片側ずつである。
- **(3) における可逆性そのもの。** 原文 Step 3 は `(AB)⁻¹ = B⁻¹A⁻¹` を両側逆元の一意性から
  導いているが、合成則の中身は `a (b x u) v = (a b) x (u v)`、つまり**結合法則だけ**である。
  逆元は「合成した右因子 `u v` を `(AB)⁻¹` と呼び直す」ためにしか使われていない。
  実際、既存の具体版 `Conjugation.matrix_conj_comp` も `A, B` の正則性を仮定せずに成立している
  （mathlib の `Matrix.inv` が全域関数で `Matrix.mul_inv_rev` が無仮定に成り立つため）。

## 具体版が過剰な構造を要求していないかの検査結果

具体版（`Claim045_ConjugationIsRingHomAbstract.lean`）は、抽象版と具体的な主張の間を
「正則行列 `B` が行列環の単元であり、その単元の逆元が `Matrix.inv` の `B⁻¹` と一致する」
という橋渡し（`Ising2D.matUnit`、mathlib の `Matrix.nonsingInvUnit` により定義的に一致）だけで
埋めており、それ以外の性質を使っていない。**具体版が抽象版より強い構造を要求している箇所は無い。**

なお、原文が `Mat(n,ℂ)` に限定して述べていること自体はプロジェクトのゴール設定
（`exact-solution-of-2d-ising-model/README.md` 4 節: 人手証明は具体に固定する）に沿ったもので、
ここでの検査結果は本文の抽象度を上げる根拠にはしない。
