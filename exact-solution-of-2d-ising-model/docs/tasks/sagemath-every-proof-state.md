# 全ての証明に SageMath の検算を付ける — 状態台帳

手順は [sagemath-every-proof-runbook.md](sagemath-every-proof-runbook.md)。

## 現在地

2026-11-01: 証明を持つブロック 214 件のうち、SageMath の検算が無いもの 116 件（`node sagemath/tools/verify-every-proof-has-check.ts`）。

済んだもの（文書順）:

- `mat_columnwise`（行列の積は列ごとに作用する）: `sagemath/check/mat_columnwise/`。証明の成分計算の四行と主張を、`QQ` 上の多項式環の不定元で厳密に確かめた。主張に `m,n,p ∈ Z_{≥1}` の帰属を足した。
- `radial_normalization_exists_unique`（非零実数対の単位円への正規化）: `sagemath/check/radial_normalization_exists_unique/`。一般の点は `QQ(x,y)` 上の「`r` が可逆なだけの環」と「`r^2 = x^2+y^2` を持つ環」に分けてどの行がどの関係式を使うかを示し、正負・大小に依る行は `AA`（実代数的数）の具体の点で厳密に確かめた。レビューの指摘で人手証明を直した（`\mathbf R` を `\mathbb R` に統一、`x^2+y^2>0` を場合分けの不等式の鎖に、`r>0`・`r x_c = x`・`r' = √(x^2+y^2) = r` を (∵) 付きの鎖に、平方根の定義・単位円の定義・平方根の一意性への `blkref` を追加、`r', x_c, y_c` の帰属を明記）。計算の誤りは無かった。
- `arcsin_is_bijection`（arcsin の値域・狭義単調増加・全単射・連続）: `sagemath/check/arcsin_is_bijection/`。証明は外部文献の引用だけだったので、弧の長さを内接折れ線と外接折れ線で `RealBallField` の区間に挟み、値域・三つの場合の狭義単調増加・全射の証人 `sin(kπ/24)`（`AA` で厳密）を確かめた。レビューの指摘で人手証明を直した（`def_arcsin` の二つの式が `y = 0` で重なっていたのを第二の式を `-1 ≤ y' < 0` に限って解消、終域を `ℝ` にして値域を主張の側へ移した、主張を四項に書き下し、文献に委ねるのを `f(y) := l(AP)` の狭義単調増加と像 `[0,π/2]` だけにして、負の側への拡張・全射・連続を本文で示した、`def_sin` を全単射の項から定める形にした）。計算の誤りは無かった。
- `arctan_argument_in_unit_interval`（arctan の引数は arcsin の定義域に入る）: `sagemath/check/arctan_argument_in_unit_interval/`。`QQ[x]` の差の恒等式と `AA` の具体の点で全て厳密に確かめた（浮動小数点なし）。レビューの指摘で人手証明を直した（平方根を取る前に `1+x^2 ≥ 1 > 0` を示す順に改め主張にも平方根が定まることを書いた、`s > 0` の推論、`|x| ≤ s` を背理法の鎖に、絶対値の商と `|s| = s` を二行に、最後の同値を必要な向きの鎖に、`x ∈ ℝ` の理由）。計算の誤りは無かった。

## 次の一歩

`000_calculation_formulae_20_29.ts` の `multiplicative_group_of_polar_representation`（`--list` の先頭）から、文書順に検算を足す。

## 検算で見つかった本文の誤り

- 2026-11-01、`mat_columnwise` のレビューで見つかった（計算の誤りではなく「同一視をしない」規律への違反）:
  行列の積の定義（`mat_mult`）は「数ベクトルは n 行 1 列の行列とみなし」と書き、正定値行列の定義
  （`def_hermitian_positive_definite`）も「1×1 行列を ℂ と同一視する」と書いている。ベクトルの転置 `x^⊤`・
  共役転置 `x^*` は本文で定義されておらず、`psd_cauchy_schwarz`・`exp_hermitian_is_positive_definite`・
  熱力学極限の二つのファイルの `x^⊤Px`・`x^*Ax` が約 60 箇所これに依存する。`mat_mult` から同一視だけを
  削ると依存先の根拠が無くなるので、この単位では直さなかった。直すには、ベクトルと n×1 行列・1×1 行列と ℂ の
  間の写像に名前を付けて定義するか、双線型形式 `x^⊤Py := Σ x_k P_{kl} y_l` を定義して依存先を書き換える。
  依存先のブロックの検算を足すときに合わせて扱う。
- 2026-11-01、`arctan_argument_in_unit_interval` のレビューで見つかった（計算の誤りではなく未定義の概念）:
  実数の絶対値 `|q|` を定義するブロックが本文に無い。本文にある絶対値の定義は複素数の絶対値と偏角（`def_abs_arg`、
  `000_calculation_formulae_30_44.ts`）だけで、しかも後ろにある。`arctan_argument_in_unit_interval` の根拠
  （絶対値の二乗・商・`q ≤ |q|`）と `arcsin_is_bijection` の連続性の証明（`|y-y_0|<δ`）がこれに依存する。
  直すには、計算公式の章の前の方に `|q| := max(q,-q)` の定義と、使う性質の主張を置き、依存先から引く。この単位では直さなかった。
