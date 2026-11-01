# SageMath Check: scalar_exp_zero

## 対象

**対象ラベル**: `scalar_exp_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_009_claim_scalar_exp_zero`（`exp(0) = 1`）
- 範囲: 証明の準備（`O = [0]_K` と `[0]^m = O`）、部分和の十行、ノルムの三行、最後の三行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `O = [0]_K` と `([0]^m)_11 = ([0]^{m-1}[0])_11 = Σ_{j=1}^{1}… = ([0]^{m-1})_11([0])_11 = ([0]^{m-1})_11·0 = 0`、帰結 `[0]^m = [([0]^m)_11] = [0] = O` | `check_zero_matrix_powers.sage` | 第一辺は Sage の冪、第二辺は本文の冪の定め方、第三辺は積の成分の和で作る。対照として `[0]^0 = I ≠ O` | **PASS** | `m = 1,…,30` で厳密等号 |
| 部分和の十行 `S_N([0]) = Σ(1/m!)[0]^m = (1/0!)[0]^0 + … = (1/0!)I + … = I + … = I + Σ(1/m!)O = I + ΣO = I + O = I = [I_11] = [1]` | `check_partial_sums_of_zero_matrix.sage` | 第一辺は本文の冪の定め方で作った部分和、第二辺以降は Sage の冪と行列演算で作る | **PASS** | `N = 0,…,30` で厳密等号 |
| ノルムの三行 `‖S_N([0]) - [1]‖ = ‖[1] - [1]‖ = ‖O‖ = 0` | `check_partial_sums_of_zero_matrix.sage` | 差が零行列で、`def_matrix_norm` の根号の中 `Σ|a_ij|^2` が 0 であること（平方根を取らずに厳密に確かめる） | **PASS** | `N = 0,…,30` |
| 最後の三行 `exp(0) = (exp([0]))_11 = ([1])_11 = 1` | `check_partial_sums_of_zero_matrix.sage` | 最後の行 `([1])_11 = 1` の成分の取り出し | **PASS** | 厳密等号 |

第一行と第二行の比較のうち、`line1` と `line2`（第 0 項を分ける）、`line3` と `line4`（`1/0! = 1`）のように、
一方の式からもう一方を直接作った比較は構成上かならず一致する。各鎖の両端は独立な経路（本文の冪の定め方と Sage の冪）で作ってあり、
そちらの一致が検算の実体である。

## 計算の帰属と範囲

- **厳密**: `QQ`（`K = R`）と `QQ(i)`（`K = C`）で計算した。浮動小数点とボールは使っていない。

範囲外のもの:

- 極限についての段（値が 0 の定数の実数列は 0 に収束すること、`S_N([0]) → exp([0])`（`def_exp` (1)）、
  極限の一意性（`matrix_norm_triangle_inequality` (4)））は、有限個の値では確かめられない。
- 一般の `m`・`N` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh scalar_exp_zero
```

共通の準備は `sagemath/_shared/one_by_one_matrix.sage`。実行ログは `logs/` に保存する。
