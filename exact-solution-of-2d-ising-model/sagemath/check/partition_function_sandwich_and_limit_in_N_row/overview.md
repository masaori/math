# SageMath Check: partition_function_sandwich_and_limit_in_N_row

## 対象

**対象ラベル**: `partition_function_sandwich_and_limit_in_N_row` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
  （ブロック `row_limit_and_max_eigenvalue_claim_sandwich_and_limit_in_N_row`）
- 主張: `W = V_1^{1/2}V_2V_1^{1/2}`、`c(M) = sup{x^⊤Wx | ‖x‖ = 1} > 0` のもとで
  (1) `c(M)^N ≤ Z(K_1,K_2) ≤ 2^M c(M)^N`（`N ≥ 1`）、(2) `lim_{N→∞} (1/(MN)) log Z = (1/M) log c(M)`
- 範囲: 主張の前提（`W` の実対称性、`c(M) > 0`）、proof の (1)（`partition_function_sandwich`）と
  (2)（`limit_of_log_Z_in_N_row`。その証明の最後の不等式 `|(1/(MN)) log Z − (1/M) log c| ≤ (log 2)/N`）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal_chain.sage | 前提: `W` の虚部と非対称部分の相対量が `1e-12` 以下、`c(M)`（`W` の最大固有値として数値で作る）が正、乱数の単位ベクトル 50 本で `x^⊤Wx ≤ c(M)`。(1) `Z` を `def_partition_function_2d_ising` のスピン配置の直接和で作り（`M·N ≤ 9` の格子）、`Z = tr(W^N)` の相対残差が `1e-10` 以下、`c^N ≤ Z ≤ 2^M c^N` が相対 `1e-9` の余裕で成り立つこと。(2) `N = 1,…,50, 100, 200, 500, 1000` で（`log Z` の作り方は備考） `|(1/(MN)) log Z − (1/M) log c| ≤ (log 2)/N`、`N = 1000` で誤差が `1e-3` 以下。否定コントロール: 上界の `2^M` を `1` にした `Z ≤ c^N`、下界の `c` を `1.05c` にした `(1.05c)^{1000} ≤ Z`、極限値を `(1/M) log(2c)` にしたものが、すべての組で成り立たないこと（`M ∈ {2,3,4}`、`(K_1,K_2)` 8 組。臨界点上 `K_1 = K_2 = K_c` を含む） | PASS | 前提: 相対量 ≤ 7.2e-17、`c(M)` の最小値 10.04、`(x^⊤Wx − c)/c` の最大 −1.9e-3。(1) `Z = tr(W^N)` の相対残差 ≤ 5.6e-15、`(Z − c^N)/Z` の最小 6.5e-2、`(2^M c^N − Z)/Z` の最小 0.79。(2) 誤差/`((log 2)/N)` の最大 0.68、`N = 1000` の誤差 ≤ 1.9e-11。否定コントロールはすべて破れた |

## 備考

- **ℝ 脱出（指数評価・完備性・実対数）**: `W` は行列の指数関数から作るので成分が超越数になり、`c(M)` は実数の上限、
  `log` は実対数である。いずれも厳密計算できないので、倍精度 `CDF`・`RDF` で計算した。
- `c(M)` を `W` の最大固有値として作るのは検算の手段である。本文は `c(M)` を上限として定義し、固有値の存在を使わない。
- (2) の `log Z` は、`M·N ≤ 9` の格子では直接和の `Z` から作り、それより大きい格子では `Z` が倍精度で溢れるので
  `log Z = N log c + log tr((W/c)^N)` と作った（`Z = tr(W^N)` は `Z_equals_trace_of_W` で、(1) で直接和と照合済み）。
  `(W/c)^N` は行列の積で直接計算し、`W` の固有値分解は使わない（固有値で `Σ_k (w_k/c)^N` と書くと
  `1 ≤ Σ ≤ 2^M` が作り方から自動的に従い、検算にならないため）。
- 共通定義（`SpinOps`・`W_matrix`・`to_real`・`Z_direct`）は `044_claim_max_eigenvalue/_prelude.sage` とその土台の
  `043_claim_transfer_matrix_bridge/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/partition_function_sandwich_and_limit_in_N_row
sage check_goal_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
