# SageMath Check: sqrt_squared_is_original

## 対象

**対象ラベル**: `sqrt_squared_is_original` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_041_claim_sqrt_squared_is_original`（sqrt の2乗は元に戻る）
- 範囲: 主張 `√z·√z = z` と、証明の式変形の十の式（行 0 〜 行 9）

## 証明の行との対応

`A := (√r, θ/2 - nπ)` と書く。`(r, θ)` は `φ_polar(z) = [(r,θ)]` の代表元、`n` は `0 ≤ θ - 2nπ < 2π` を満たす整数。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 行 0 → 1（`sqrt_expansion_via_polar`） | `check_chain.sage` | 行 0 の `√z` は、固定した代表元 `p0` から `def_sqrt_cc` の式どおり（類の半径の平方根、角度の類の `[0,2π)` の代表元を `⌊q/2⌋` で求めてその半分）に作る。行 1 の `A` は、取り替えた各代表元 `p` から `n` を候補の総当たりで求めて作る。両者の `φ_cart` を ℂ の元として比べる | **PASS** | 47 組 |
| 行 1 → 2（`φ_cart` が積を保つ） | `check_chain.sage` | `φ_cart([A])·φ_cart([A])`（ℂ の積の定義）と `φ_cart([A]·[A])` を別々に計算して比べる | **PASS** | 47 組 |
| 行 2 → 3（極座標表現の演算） | `check_chain.sage` | 代表元の積が行 3 の対に一致する。定義の適用であり、検算の積は行 3 と同じ式を返すので独立な比較ではない | **PASS** | 47 組 |
| 行 3 → 4（`√r·√r = r`） | `check_chain.sage` | 定義の適用。具体の点で、`√r` を作るときに `y ≥ 0` かつ `y² = r` を `AA` で確かめ、行 3 と行 4 の第 1 成分の等号を `AA` で比べる | **PASS** | 47 組 |
| 行 4 → 5（和の交換律と結合律）、行 5 → 6（`θ/2+θ/2 = θ`、`nπ+nπ = 2nπ`） | `check_chain.sage` | 一般の点で多項式の等式。具体の点で角度の等号 | **PASS** | 一般の点と 47 組 |
| 行 6 → 7（同値関係） | `check_chain.sage` | 一般の点で角度の差が `2·(-n)·π`。具体の点で、角度の差と、`polar_equivalence_class` の式どおりの類の判定と、`φ_cart` の値の一致 | **PASS** | 一般の点と 47 組 |
| 行 7 → 8（`r, θ` の取り方） | `check_chain.sage` | `φ_polar(z) = [(r,θ)]` を `def_phi_polar` の場合分けどおりに判定する（下記）。対照として、場合分けの六つの場合のどれでも、取り違えた代表元で判定が落ちること | **PASS** | 47 組と対照 7 つ |
| 行 8 → 9（`φ_cart ∘ φ_polar = id`） | `check_chain.sage` | `φ_cart([(r,θ)])` が座標で直接与えた `z` に一致する | **PASS** | 47 組 |
| 主張 `√z·√z = z` | `check_statement.sage` | `def_sqrt_cc` の式どおりの `√z` を ℂ の積で二乗して `z` と比べる。代表元を替えても `√z` が変わらないこと。対照として、`[0,2π)` の代表元を使わず角度の半分を取ると代表元によって値が `-1` 倍になること | **PASS** | 12 個の `z`、47 組 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。準備は `sagemath/_shared/polar_trigonometry_exact.sage`（`sagemath/_shared/polar_representation.sage` を読む）と、標本を置く `_prelude.sage`。

- **一般の点**: 角度・整数 `n`・`π` を `QQ` 上の不定元とする多項式環。
- **具体の点**: `z` は座標 `(x, y) ∈ AA × AA` で直接与える（`0`、`1`、`-2`、`3i`、`-i/2`、`1+i`、`-√3+i`、`-1-i`、`5√3-5i`、`(1+√3 i)/2`、`-7(1+√3 i)/2`、`((√6+√2)+(√6-√2)i)/4`）。
  代表元の角度は `π` の有理数倍 `qπ` に限り、各 `z` について 2π ずらした代表元を四つ（半径零なら角度を替えた三つ）取る。
  `cos(qπ)`・`sin(qπ)` は 1 の冪根 `e^{iqπ}` の実部・虚部として `QQbar` で厳密に作る。
- `φ_polar(z) = [(r,θ)]` の判定: `arctan` の値は作らない。`def_arctan` により `arctan(t) = arcsin(t/√(1+t²))` で、
  `arcsin` は `[-1,1] → [-π/2,π/2]` の全単射、`sin` はその逆写像（`arcsin_is_bijection`・`def_sin`）だから、
  `α ∈ [-π/2,π/2]` について `arctan(t) = α ⟺ sin α = t/√(1+t²)`。`θ` から場合分けの定数（`0`、`±π`）と `2kπ` を引いて
  `[-π/2,π/2]` に入る `α` を作り、`sin α = (y/x)/√(1+(y/x)²)` を `AA` で確かめる。`x = 0` の場合は定義の式どおりに比べる。

確かめられない点と理由:

- 本文の `def_sin`・`def_cos` は `[-π/2, π/2]` でしか定めておらず、`def_phi_cartesian` 自身が「全実数上への拡張と周期性が未整備のため未完」と書いている。
  検算で使う `cos(qπ)`・`sin(qπ)` はその外では通常の値であり、本文が未整備の拡張を先取りしている。
- 半径・角度が `AA` や `π` の有理数倍に入らない `z` は検算の範囲外で、人手証明が担う。
- 行 1 → 2 と行 8 → 9 は具体の値での一致の確認である。一般の証明は、積の保存は `isomorphism_of_phi_cartesian` の検算
  （`115_isomorphism_of_phi_cartesian`）、`φ_cart ∘ φ_polar = id` は `phi_cartesian_after_phi_polar_is_identity` の検算が担う。
- `def_sqrt_cc` の `pr_2` は `first_and_second_projections` どおり、半径が `0` なら `[0]_angle` とした。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sqrt_squared_is_original
```

実行ログは `sagemath/check/sqrt_squared_is_original/logs/` に保存する。
