# SageMath Check: c_plus_value_c_sandwich_and_double_limit_of_log_Z

## 対象

**対象ラベル**: `c_plus_value_c_sandwich_and_double_limit_of_log_Z` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
  （ブロック `column_limit_and_closed_form_claim_c_plus_sandwich_and_double_limit`）
- 主張: `K_1, K_2 > 0`、`M ≥ 2` で (1) `c_+(M) = Λ^{(1/2)}_M`、(2) `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`、
  (3) `lim_{M→∞} lim_{N→∞} (1/(MN)) log Z = (1/2) log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ(θ) dθ`
- 範囲: proof の (1)（`c_plus_equals_Lambda_half_integer`）、(2)（`c_between_Lambda_half_and_twice_Lambda_half`）、
  (3)（`onsager_exact_solution`。`N → ∞` の評価と、`M → ∞` の側の有限 `M` での評価と極限値への接近）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal_chain.sage | (1) `c_+(M)`（`W` を `F^{(+)} ∩ ℝ^{2^M}` の正規直交実基底へ制限した行列の最大固有値）と、`θ̃_μ` の `γ` の和から作った `Λ^{(1/2)}_M` の一致。(2) `c(M)`（`W` の最大固有値）の挟み込み。(3) `N = 1,…,64` で `|(1/(MN)) log tr(W^N) − (1/M) log c(M)| ≤ (log 2)/N`（`(W/c)^N` は行列の積）、有限 `M` で `|(1/M) log c(M) − (1/M) log Λ^{(1/2)}_M| ≤ (log 2)/M`、`M = 4,16,…,4096` で `(1/M) log Λ^{(1/2)}_M` が極限値（数値積分）に近づくこと。否定コントロール: (1) の右辺を `Λ^{(0)}_M` にしたもの、(3) の積分の係数を `1/(2π)` にしたものが成り立たないこと。(2) の上界を `0.99Λ` にしたものが破れることは下界の鋭さの確認である（上からの評価の否定コントロールは `c_between_Lambda_half_and_twice_Lambda_half` の検算が持つ）（`M ∈ {2,3,4,5}`、`(K_1,K_2)` 6 組。臨界点上を含む。極限値は 3 組） | PASS | (1) 相対残差 ≤ 2.2e-15。(2)・(3) の評価の違反 0 件。`M = 4096` での極限値との差 ≤ 1.6e-8（臨界点上。ほかの 2 組は 3e-15 以下）。否定コントロールと下界の鋭さの確認はすべて破れた（`Λ^{(0)}_M` との相対差の最小は 7.5e-7 で、(1) の残差より 8 桁大きい） |

## 備考

- **ℝ 脱出（指数評価・完備性・実対数・極限・積分）**: `W` の成分は超越数、`c(M)`・`c_+(M)` は実数の上限、
  `Λ^{(1/2)}_M` は実数の指数関数と `arccosh` の値、`log` は実対数、極限値は Riemann 積分である。
  厳密計算できないので倍精度 `CDF`・`RDF` で計算し、積分は `numerical_integral` で作った。
- 極限そのものは有限の計算では確かめられない。(3) で確かめたのは、証明が使う有限の不等式と、
  `M` を大きくしたときに極限値へ近づくことである。
- `c(M)`・`c_+(M)` を最大固有値として作るのは検算の手段である。本文は上限として定義し、固有値の存在を使わない。
- 否定コントロールの (1) は、`Λ^{(0)}_M` と `Λ^{(1/2)}_M` が低温側で指数的に近づくため、相対差 `1e-10` を閾値にした。
- 共通定義は `053_claim_even_sector_closing/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/c_plus_value_c_sandwich_and_double_limit_of_log_Z
sage check_goal_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
