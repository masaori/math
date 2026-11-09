# SageMath Check: half_integer_phase_antiperiodicity

## 対象

**対象ラベル**: `half_integer_phase_antiperiodicity`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensector_003_claim_half_integer_phase_antiperiodicity`（`exp(-i((M_col)_R θ̃_μ)_C) = -1_C`）
- 範囲: 証明の二つの鎖（指数の中の実数の 6 等号、主張の左辺から -1_C までの 17 等号）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(M)_R θ̃_μ = (M)_R·2π(μ_R-1/2)/(M)_R = 2π(μ_R-1/2) = 2πμ_R - 2π·(1/2) = 2πμ_R - π(2·(1/2)) = 2πμ_R - π = -π + 2πμ_R` | `check_angle_chain.sage` | π・μ・M を不定元にした `QQ` 上の有理関数体で各行を式の形のまま組み、隣と比べる。具体の M = 2..8、μ = -2M..2M で 角度/2π の一致も見る。対照: 2·(1/2) を 1/2 にすると 2·(1/2) = 1 の行が崩れる | **PASS** | 成り立つ |
| 左辺 → `exp(-(i((M)_R θ̃_μ)_C))`（`negative_i_times_complex_is_negation_of_i_times`）→ `(cos)_C - i(sin)_C` → 代入 → 2π 周期性 → `cos_of_negated_real` → `sin_of_negated_real` → cos π = -1 → sin π = 0 → `(0_R)_C = 0_C` → `-0_C = (-1_C)·0_C` → `(-1_C)·0_C = 0_C` → `i·0_C = 0_C` → 差の定義 → `-0_C = (-1_C)·0_C` → `(-1_C)·0_C = 0_C` → 和の単位元 → `(-1_R)_C = -1_C` の 17 等号 | `check_exp_chain.sage` | M = 2..8、μ = -2M..2M で、各行をその行の角度の cos・sin（AA）と ℂ の演算（`QQbar`）で組み、隣と厳密に比べる。周期性・`cos_of_negated_real`・`sin_of_negated_real`・cos π・sin π の行は Arb の cos・sin（1 の冪根を経ない計算）でも重なることを見る。第 1 等号は両辺の指数 `(-i)((M)_R θ̃_μ)_C`・`-(i((M)_R θ̃_μ)_C)` を有理関数体の上の実数の対で厳密に比べる。対照: μ を半整数にずらすと周期性の行が崩れる。第 1 等号で符号を落とすと崩れる。ただし第 0→1・第 1→2・第 2→3・第 3→4 等号の `QQbar` の比較は作り方で自明（下記） | **PASS** | 成り立つ |
| 主張、および第 2 等号（exp と cos・sin を結ぶ `exp_of_negative_i_real_as_cos_minus_i_sin`） | `check_claim_ball.sage` | θ̃_μ を定義の式のまま π のボールで組み、本文の exp のボールが -1 と重なり、`check_exp_chain.sage` の第 0 行の 1 の冪根を含むことを見る。対照: 整数運動量 2πμ/M では -1 と交わらない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 角度の鎖は π を不定元にした有理関数体。cos・sin の値は角度 2πq（q ∈ `QQ`）の 1 の冪根の実部・虚部（AA）、ℂ の元は `QQbar`。
- **ℝ への脱出**: Arb の cos・sin の行（`check_exp_chain.sage`）と `check_claim_ball.sage`。π と本文の exp の値を 512 bit のボールで囲む。重なりは等号の必要条件であって証明ではない。
- 全実数上の cos・sin（2π 周期性、偶奇性（本文は `cos_of_negated_real`・`sin_of_negated_real` を引く）、cos π = -1、sin π = 0）は本文では未整備（`euler_formula_cos_sin` の前置き）で、主張はそれを前提とする。検算では通常の cos・sin の値を使う。
- **作り方で自明な比較**: 1 の冪根 E(q) は指数を 1 を法として落とし、cos・sin の AA の値も E の実部・虚部から作るので、
  `check_exp_chain.sage` の第 0→1 等号（指数の書き換え。同じ 1 の冪根）、第 1→2 等号（exp と cos・sin。同じ 1 の冪根から作る）、第 2→3 等号（代入。角度が有理数として同じ）、
  第 3→4 等号（2π 周期性。角度の差が整数 μ）の `QQbar` の比較は必ず成り立ち、中身を持たない。
  周期性・`cos_of_negated_real`・`sin_of_negated_real`・cos π・sin π の行の中身は Arb の cos・sin の検査が、第 1 等号の中身は指数の実数の対の厳密な比較が、第 2 等号の中身は `check_claim_ball.sage`（本文の exp のボール）が担う。
- 像の行（`(0_R)_C = 0_C`、`(-1_R)_C = -1_C`）と `-0_C`・`(-1_C)·0_C` の行は `QQbar`・`AA` の上では自明に成り立つ比較で、値の計算が通ることを確かめるだけである。
- 範囲外: M_col ≥ 9、\|μ\| > 2M。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh half_integer_phase_antiperiodicity
```

実行ログは `logs/` に保存する。
