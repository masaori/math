# SageMath Check: extract_taylor_coefficient_of_check_Z_Y

## 対象

**対象ラベル**: `extract_taylor_coefficient_of_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_004_claim_extract_taylor`（Ž・Y̌ についてのテイラー係数の抽出 (h1.z)・(h1.y)・(h2.z)・(h2.y)）
- 範囲: 証明の準備 `2(K_2^*)_C = (2K_2^*)_C`、四つの式それぞれの偶数・奇数の場合の鎖、`exponential_series_of_even_odd_power_terms` を当てる行、行列の和の可換律の行、主張そのもの

## 証明の行との対応

`k1 := (K_1)_C`、`k2 := (K_2^*)_C`、`e_∓ := exp(∓i(θ̃)_C)`、`G_1`・`G_2` は証明の記号。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `2(K_2^*)_C = (2_R)_C(K_2^*)_C = (2K_2^*)_C` の 2 行 | `check_hypothesis_forms_and_chains.sage` | ℂ を実数の対で持ち、K_2^* を `QQ` 上の不定元にして各行を対の積と包含で作る。対照: `2(K_2^*)_C ≠ (K_2^*)_C` | **PASS** | 厳密 |
| (h1.z)・(h1.y) の偶数の場合の 1 行、奇数の場合の 4 行 | 同上 | 左辺の項 `ad^n_{G_1}(W)` を Sage の演算の再帰で生成子から直接作り、`cosh_sinh_coefficient_conversion_for_check` の右辺、補題の仮定の形 `(k1)^n A`・`(c k1^n) B`（c = i e_-、(-i) e_+）と一致 | **PASS** | `M_col = 2..5`、全 μ、n = 0..7 |
| (h2.z)・(h2.y) の偶数の場合の 2 行、奇数の場合の 2 行 | 同上 | 同上（生成子 `G_2`、x = 2K_2^*、c = -i、i） | **PASS** | 同上 |
| 補題を当てる行、(h1.y)・(h2.y) の和の可換律の行 | 同上 | cosh・sinh の値を独立な不定元に置き、補題の右辺 `(cosh x)_C A + (c(sinh x)_C)B` を作って、可換律で並べ替えた式が主張の右辺と一致 | **PASS** | 同上 |
| 対照 | 同上 | (h1.z) n = 1 で位相を逆にした形（e_- ≠ e_+ の μ）、(h2.z) n = 1 で c の符号を逆にした形は補題の仮定の形にならない | **PASS** | 同上 |
| 主張 (h1.z)・(h1.y)・(h2.z)・(h2.y) | `check_claim_by_partial_sums.sage` | K_1 = 3/10、K_2^* = 7/10 で級数の部分和 S_60 を円分体の中で厳密に作り、主張の右辺との差のノルムが 10^{-40} 未満（最大でも 1.3e-74）。対照: 奇数側の係数の符号を逆にした式とは 10^{-3} 以上離れる | **PASS** | `M_col = 2, 3, 4`、全 μ |

## 計算の帰属と範囲

- 共通の準備は `_shared/half_integer_check_operators.sage`（Z_m・Y_m・H_1^(+)・H_2・Ž_μ・Y̌_μ を本文の成分の式で作り、位相を円分体 `QQ(ζ_{4M})` の 1 の冪根で持つ）、`_shared/complex_as_real_pairs.sage`、`_shared/one_by_one_matrix.sage`。
- 鎖の検算では k1・k2 を円分体上の多項式環の不定元に置き、浮動小数点を使わない。位相の表し方と本文の exp の値との照合は `nesting_of_commutator_of_H_and_check_Z` の検算が行う。
- 主張の検算だけは、cosh・sinh の値が `QQ` に収まらないので ℝ へ脱出する。exp は `body_real_exp_ball`（本文の部分和に尾の評価を半径として足したボール。512 bit。Arb の exp は使わない）、円分体の元は ζ_{4M} を QQbar の exp(2πi/(4M)) へ送る埋め込みで複素数のボールへ移す。級数の極限そのもの（全ての N への一般化）は確かめられないので、部分和との差が小さいことで確かめる。極限の推論は `exponential_series_of_even_odd_power_terms` の検算が受け持つ。

## 確かめられない行と理由

- 準備の `2(K_2^*)_C = (2K_2^*)_C` を使って `(2k2)^n` を `((2K_2^*)_C)^n` に書き換える行は、不定元の環では同じ元なので一致は作り方から必ず通る。等しさそのものは準備の行を対の ℂ で確かめた。
- 「ℂ の積の可換律・結合律」で係数を並べ替える行も、可換環の元として作るので同じである。
- (h1.z)・(h2.z) で `exponential_series_of_even_odd_power_terms` を当てた行の値と主張の右辺は、同じ式を二度書いたものなので、一致は作り方から必ず通る。補題の仮定が満たされることは偶数・奇数の場合の検算が、補題の結論そのものは `exponential_series_of_even_odd_power_terms` の検算が、主張の値は `check_claim_by_partial_sums.sage` が確かめる。(h1.y)・(h2.y) では和の可換律で並べ替えた後の値を、主張の右辺と比べる。
- 帰納法と主張の全ての n・M_col への一般化は確かめられない。範囲は表の「結果」のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh extract_taylor_coefficient_of_check_Z_Y
```

`check_hypothesis_forms_and_chains.sage` と `check_claim_by_partial_sums.sage` は引数で `M_col` を絞れる。実行ログは `logs/` に保存する。
