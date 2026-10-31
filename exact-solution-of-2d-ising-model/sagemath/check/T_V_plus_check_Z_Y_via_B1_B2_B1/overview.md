# SageMath Check: T_V_plus_check_Z_Y_via_B1_B2_B1

## 対象

**対象ラベル**: `T_V_plus_check_Z_Y_via_B1_B2_B1` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
  （ブロック `reduction_to_A_theta_claim_T_V_plus_check_Z_Y_via_B1_B2_B1`）
- 主張: `μ ∈ M̌` について
  `(V^{(+)} Ž_μ (V^{(+)})^{-1}, V^{(+)} Y̌_μ (V^{(+)})^{-1}) = (T_{(V^{(+)})}(Ž_μ), T_{(V^{(+)})}(Y̌_μ)) = (Ž_μ, Y̌_μ) A(θ̃_μ) = (Ž_μ, Y̌_μ) B_1(θ̃_μ) B_2 B_1(θ̃_μ)`
- 範囲: proof の式変形 4 行（`def_T_g` を `g = V^{(+)}` として、`T_V_plus_is_conjugation`、`T_V_plus_check_Z_Y`、
  `factorization_of_A_theta_general` を `θ = θ̃_μ` として）。1・2 行目は check_conjugation_chain.sage、3・4 行目は check_substitution_chain.sage

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_conjugation_chain.sage | 1・2 行目: 右端（`def_T_V_plus` の三つの共役の合成 `L0`）が `L0 V^{(+)} = V^{(+)} X` を満たすこと（`V^{(+)}` が可逆なので `L0 = V^{(+)} X (V^{(+)})^{-1}` と同値）。相対残差 `‖L0 V^{(+)} − V^{(+)} X‖ / (‖V^{(+)}‖ ‖X‖)` が `1e-8` 以下。`X` は `Ž_μ`・`Y̌_μ`（全 `μ`）と、追加の確認として成分の実部・虚部が -3 以上 3 以下の整数の乱択行列 3 個。否定コントロール（向きを逆にした `(V^{(+)})^{-1} X V^{(+)}`）は、少なくとも一つの `X` で相対残差が `1e-3` を超えること（`X` についての最大値で判定）（`M_col ∈ {2,3,4,5}`、`EVEN_PARAMS` の 5 組） | PASS | 最大相対残差 7.4e-13、否定コントロールの相対残差の最小値 2.3 |
| check_substitution_chain.sage | 3・4 行目: 2 行目の右辺 `T_{(V^{(+)})}(X)`（三つの因子の共役の合成として作ったもの。プログラムの `line0`）・3 行目の右辺（`line1`）・4 行目の右辺（`line2`）の値を各行の式どおりに独立に作り、隣どうしの残差（作用素ノルム）が `1e-8` 以下であること。否定コントロール（4 行目の積の順序を `B_2 B_1 B_1` にしたもの）は少なくとも一つの `μ` で `line0` と一致しないこと（`M_col ∈ {2,3,4,5}`、`μ ∈ {1,…,M_col}`、`047_claim_even_sector_T_action` の `EVEN_PARAMS` の 5 組） | PASS | 最大残差 8.8e-11、否定コントロールの残差（`μ` についての最大値）≥ 1.03 |

## 備考

- **ℝ 脱出（指数評価）**: `(V_1^{(+)})^{1/2} = exp((i/2)K_1H_1^{(+)})` と `V_2` は、実数の `K_1, K_2^*` と固有値が一般に
  無理数の `H_1^{(+)}, H_2` から作るので成分が超越数になり、厳密計算できない。倍精度複素数 `CDF` で計算した。
- 共通定義（`SpinOps`・`checkZ`・`checkY`・`B1`・`B2`・`A_theta`・`V1p_half`・`V2_mat`）は
  `047_claim_even_sector_T_action/_prelude.sage` を使う。
- `M_col` が奇数のとき `μ = (M_col+1)/2` では `θ̃_μ = π` で、`B_1(π)` と `B_2` が可換になるので、否定コントロールの積も
  `line0` と一致する。そこで否定コントロールは `μ` についての残差の最大値で判定した。
- 3 行目の等号（`T_V_plus_check_Z_Y`）は `047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage` が、
  4 行目の等号（`factorization_of_A_theta_general`）は同じファイルの (1) が確かめている。ここでは二つを続けた結果の一致を確かめる。

- 1・2 行目の判定で `(V^{(+)})^{-1}` を使わない（否定コントロールの値を作るときだけ因子の逆行列の積を使う）のは、`K_2 = 0.1` のとき `V^{(+)}` の条件数が大きく、
  `V^{(+)}` の逆行列を数値で求めて使うと丸め誤差だけで相対残差が `4.9e-8` になり許容 `1e-8` を超えるためである。
- 1 行目の右辺 `T_{V^{(+)}}(X)` は左辺を `def_T_g` の記号で書いたもので、値は同じなので別に作らない。

## 実行方法

```bash
cd sagemath/check/T_V_plus_check_Z_Y_via_B1_B2_B1
sage check_conjugation_chain.sage
sage check_substitution_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
