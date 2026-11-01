# SageMath Check: exp_of_hermitian_is_hermitian

## 対象

**対象ラベル**: `exp_of_hermitian_is_hermitian` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_exp_of_hermitian_is_hermitian`（エルミート行列の exp はエルミート）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `SS^m = S^mS` の帰納法（`m = 0` の 4 行、`m → m+1` の 4 行） | `check_powers.sage` | 一般の `S` の成分を不定元の対に置き、`m = 0,…,4`（帰納の段は `m → m+1` の `m = 0,…,4`）、`n = 1, 2, 3` で確かめた | **PASS** | 全て PASS |
| 準備 `(S^m)^* = S^m` の帰納法（`m = 0` の 3 行、`m → m+1` の 6 行） | 同上 | `S` をエルミートな不定元の表に置き、`m = 0,…,4`（帰納の段は `m → m+1` の `m = 0,…,4`） で確かめた。`S^6` を Sage の冪・共役転置と比べた | **PASS** | 同上 |
| 部分和の成分の式と `((E_N)^*)_kl` の 8 行 | `check_partial_sums_and_limit.sage` | `S` をエルミートな不定元の表に置き、`N = 0,…,5`、`n = 1, 2, 3` の全成分で確かめた | **PASS** | 同上 |
| 極限の段と主張 | 同上 | 具体のエルミートな `QQ(i)` の行列（`n = 1,…,4`、各 3 個）で、本文の部分和に尾の評価を足したボールの行列 `exp(S)` と、その共役転置が重なること、Sage の `exp` と重なることを確かめた。エルミートでない `S` では重ならないことも確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

準備と部分和の鎖は不定元で厳密に確かめた。極限の段は `ℝ` への脱出なので、256 ビットの区間で本文の部分和と尾の上界から `exp(S)` を囲んだ（`_shared/hermitian_forms_by_definition.sage` の `body_exp_ball`）。

本文の部分和のボールを Sage 組み込みの `ComplexBallField` の `exp` と比べ、冪を Sage の行列の冪と比べた。

## 確かめられない行と理由

`N → ∞` の極限と極限の一意性は有限の計算では確かめられない。ボールの検算は、具体の行列で `exp(S)^*` と `exp(S)` の囲みが重なること（矛盾が無いこと）を確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh exp_of_hermitian_is_hermitian
```

実行ログは `sagemath/check/exp_of_hermitian_is_hermitian/logs/` に保存する。
