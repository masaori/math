# SageMath Check: 044_claim_max_eigenvalue

## 対象

**対象ラベル**: `partition_function_sandwich` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- 併せて検証:
  - `Z_equals_trace_of_W` / `W_is_real_symmetric_positive_definite` / `W_has_positive_entries`
  - `rayleigh_bounds_operator_norm` / `trace_power_sandwich`
  - `epsilon_commutes_with_W`（check_01 の `[W, ε]`）/ `symmetrized_transfer_matrix_on_sectors`（`W P^{(+)} = V^{(+)} P^{(+)}`）
  - `c_+(M) ≤ c(M)`（`c_plus_le_c`）は `check/c_plus_le_c/` が、`ε^⊤ = ε`（`epsilon_is_real_symmetric`）は
    `check/epsilon_is_real_symmetric/` が検証する

### 何を確定させるための検証か

011 章は対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` を導入し、

```
c(M)^{N_row} <= Z <= 2^M c(M)^{N_row},   c(M) = sup_{||x||=1} x^T W x
```

を**スペクトル定理を使わずに**示す。その結論と、証明の各段（実対称性・正定値性・成分の正値性・
`||Wx|| <= c||x||`・偶セクターへの射影後の表示 `W P^{(+)} = V^{(+)} P^{(+)}`）を数値で確かめる。

## 検証の枠組み

`043_claim_transfer_matrix_bridge/_prelude.sage` を土台にして、本ディレクトリの `_prelude.sage` で

| 関数 | 内容 |
|---|---|
| `D_bonds(O)` | `D = Σ_m σ^z_m σ^z_{m+1}`（周期的） |
| `V1_half(O,K1)` | `V_1^{1/2} = exp(K_1 D / 2)` |
| `W_matrix(O,K1,K2)` | `W = V_1^{1/2} V_2 V_1^{1/2}` |
| `rayleigh_sup(A)` | 実対称行列の Rayleigh 商の上限（数値固有値の最大） |

を構成する。パラメータは `M = 2,3,4`、`(K1,K2)` 7 組（`MAXEIG_CASES`）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_W_properties.sage | `W` の実対称性・正定値性・成分の正値性・`ε` との可換性・`tr(W^n)=tr((V_1V_2)^n)` | PASS | （run-log.txt 参照） |
| 02 | check_02_sandwich.sage | `c^n <= tr(W^n) <= 2^M c^n`、`‖Wx‖ <= c‖x‖`、`Z` との一致 | PASS | （run-log.txt 参照） |
| 03 | check_03_sector_split.sage | `W P^{(+)} = V^{(+)} P^{(+)}`。観測として `c(M)` と `c_+(M)` の値を並べて出力する（判定には使わない） | PASS | 残差 ≤ 7.7e-16（run-log.txt 参照） |
| — | check_B_P_equals_C_P.sage | `BP=CP` | PASS | 最大相対残差 `4.380e-16` |
| — | check_W_P_equals_B_V2_B_P.sage | `WP=BV_2BP` | PASS | 最大相対残差 `0.000e+00` |
| — | check_B_V2_B_P_equals_B_V2_C_P.sage | `BV_2BP=BV_2CP` | PASS | 最大相対残差 `4.432e-16` |
| — | check_B_V2_C_P_equals_B_V2_P_C.sage | `BV_2CP=BV_2PC` | PASS | 最大相対残差 `1.614e-16` |
| — | check_B_V2_P_C_equals_B_P_V2_C.sage | `BV_2PC=BPV_2C` | PASS | 最大相対残差 `1.356e-16` |
| — | check_B_P_V2_C_equals_C_P_V2_C.sage | `BPV_2C=CPV_2C` | PASS | 最大相対残差 `3.250e-16` |
| — | check_C_P_V2_C_equals_C_V2_P_C.sage | `CPV_2C=CV_2PC` | PASS | 最大相対残差 `2.181e-16` |
| — | check_C_V2_P_C_equals_C_V2_C_P.sage | `CV_2PC=CV_2CP` | PASS | 最大相対残差 `2.225e-16` |
| — | check_C_V2_C_P_equals_V_plus_P.sage | `CV_2CP=V^{(+)}P` | PASS | 最大相対残差 `0.000e+00` |

行単位検査の記号は本文の略記どおり `B := V_1^{1/2}`、`C := (V_1^{(+)})^{1/2}`、`P := P^{(+)}` である。

## 備考

- **`c(M)` の数値評価には固有値を使っているが、本文の証明は固有値の存在を仮定していない。**
  本文では `c(M)` を Rayleigh 商の上限として定義し、上からの評価は半正定値双線型形式の
  Cauchy–Schwarz、下からの評価はモーメント列 `m_k = x^T W^k x` の対数凸性から導いている。
  数値側は「その上限が実際に最大固有値と一致する」ことを前提に確認しているだけで、
  本文の論理には影響しない。
- **`c(M)` と `c_+(M)` が数値上一致すること**は check_03 が観測として出力しているが、本文ではこの事実を使っていない
  （本文が使うのは `c_+(M) ≤ c(M)` だけ）。`W` の成分がすべて正なので Perron–Frobenius から期待されるとおりの結果である。
- 行単位検査は `M=2,3,4`、結合定数 7 組、偶セクター `P^{(+)}` について、左右の行列の作用素ノルムによる
  相対残差を `1e-9` 以下と判定する。指数行列を `CDF`、実パラメータを `RDF` で評価する箇所が
  数値計算上の `ℝ/ℂ` への脱出であり、有限個の浮動小数点計算は一般の等式の証明ではない。

## 実行方法

```bash
for f in sagemath/check/044_claim_max_eigenvalue/check_*.sage; do sage "$f"; done
```

## 実行ログ

既存三検査の実行出力は `run-log.txt`、全検査の実行出力は `logs/` の各ファイルに保存してある（2026-09-26、SageMath 10.9）。

## 分割後の対応

プログラミングによる検証では check_03 が射影後の転送行列の最終表示を調べる。これとは独立に、上表の九検査が `BP=CP` と、その後の等式鎖を一行ずつ調べる。すべて PASS したが、有限個のパラメータでの浮動小数点計算であり、一般証明ではない。Lean では射影後の表示が未形式化であり、偶セクター接続では仮定として残る。

## (−) セクターの退避に伴う更新（2026-09-26）

(−) セクターを本文から外したとき、上限の最大値分解 `sector_decomposition_of_rayleigh_sup`（`c(M) = max(c_+, c_-)`）は
参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避され、本文には片側の不等式 `c_plus_le_c` だけが残った。
`symmetrized_transfer_matrix_on_sectors` は `W P^{(+)} = V^{(+)} P^{(+)}` だけの主張になった。これに合わせて
check_03 と九本の行単位検査を (+) セクターだけに書き直し（`check_C_V2_C_P_equals_V_pm_P.sage` は
`check_C_V2_C_P_equals_V_plus_P.sage` に改名）、全検査を再実行した。書き直す前の両セクター版は
`sagemath/_old/minus-sector/044_claim_max_eigenvalue/` に複製してある。
