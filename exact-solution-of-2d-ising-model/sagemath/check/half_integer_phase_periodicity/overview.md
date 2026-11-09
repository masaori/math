# SageMath Check: half_integer_phase_periodicity

## 対象

**対象ラベル**: `half_integer_phase_periodicity`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensector_claim_half_integer_phase_periodicity`（j ∈ ℤ で `exp(-i(j_R θ̃_{μ+M_col})_C) = exp(-i(j_R θ̃_μ)_C)`）
- 範囲: 証明の三つの鎖（θ̃_{μ+M} の 7 等号、j_R θ̃_{μ+M} の 3 等号、主張の左辺から右辺までの 6 等号）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `θ̃_{μ+M} = ⋯ = θ̃_μ + 2π` の 7 等号 | `check_angle_chain.sage` | π・μ・M を不定元にした有理関数体で各行を式のまま組んで隣と比べる。対照: 添字を M+1 ずらすと θ̃_μ + 2π にならない | **PASS** | 成り立つ |
| `j_R θ̃_{μ+M} = j_R(θ̃_μ+2π) = j_R θ̃_μ + j_R·2π = j_R θ̃_μ + 2πj_R` | `check_angle_chain.sage` | 同じ体（j も不定元）で隣と比べる。具体の M = 2..8、μ, j = -2M..2M で 角度/2π の一致も見る | **PASS** | 成り立つ |
| `exp(-i(j θ̃_{μ+M})_C) = exp(-(i(j θ̃_{μ+M})_C)) = (cos)_C - i(sin)_C = ⋯(代入)⋯ = ⋯(2π 周期性)⋯ = exp(-(i(j θ̃_μ)_C)) = exp(-i(j θ̃_μ)_C)` の 6 等号 | `check_exp_chain.sage` | 3535 組の (M, μ, j) で、exp の行は 1 の冪根、cos・sin の行はその行の角度の AA の値で組み、`QQbar` で隣と厳密に比べる。周期性の行は Arb の cos・sin でも重なる。対照: 足す角度を πj に替えると j が奇数の組で崩れる。`QQbar` の 4 つの比較は作り方で自明（下記）で、中身は Arb の行が担う | **PASS** | 成り立つ |
| 主張、および第 2・第 5 等号（`exp_of_negative_i_real_as_cos_minus_i_sin`） | `check_claim_ball.sage` | 935 組で本文の exp の両辺のボールが重なり、1 の冪根の値を含む。対照: 添字を M+1 ずらすと M ∤ j の 675 組で交わらない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 角度の鎖は有理関数体、cos・sin は AA、ℂ の元は `QQbar`。
- **ℝ への脱出**: Arb の cos・sin の行と `check_claim_ball.sage`（π と本文の exp の値、512 bit のボール）。重なりは等号の必要条件であって証明ではない。
- **作り方で自明な比較**: 1 の冪根 E(q) は指数を 1 を法として落とし、cos・sin の AA の値も E の実部・虚部から作るので、
  `check_exp_chain.sage` の 6 等号（第 1・第 2・第 5・第 6 は同じ 1 の冪根から作る、第 3 は角度が有理数として同じ、第 4 の 2π 周期性は角度の差が整数 j）の
  `QQbar` の比較は必ず成り立ち、中身を持たない。2π 周期性の中身は Arb の cos・sin の検査が、第 2・第 5 等号の中身は `check_claim_ball.sage` が、第 1・第 6 等号（`negative_i_times_complex_is_negation_of_i_times`）の中身は、指数の `(-i)x_C` と `-(i x_C)` を有理関数体の上の実数の対で厳密に比べる検査（対照: 符号を落とすと崩れる）が担う。
- 第 1 行 → 第 2 行（`ι_{Z→R}` が和を保つ）は、検算の体では整数と実数を区別しないので同じ式になり、比較は自明である。
- 全実数上の cos・sin の 2π 周期性は本文では未整備で、主張はそれを前提とする。検算では通常の cos・sin の値を使う。
- 範囲外: 鎖の検査は M_col ≥ 9 と \|μ\|・\|j\| > 2M。ボールの検査（`check_claim_ball.sage`）は M_col ≥ 7 と、μ・j が -M..2M の外。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh half_integer_phase_periodicity
```

実行ログは `logs/` に保存する。
