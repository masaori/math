# SageMath Check: 044_claim_max_eigenvalue

## 対象

**対象ラベル**: `partition_function_sandwich` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- 併せて検証:
  - `Z_equals_trace_of_W` / `W_is_real_symmetric_positive_definite` / `W_has_positive_entries`
  - `rayleigh_bounds_operator_norm` / `trace_power_sandwich`
  - `sector_decomposition_of_rayleigh_sup` / `symmetrized_transfer_matrix_on_sectors`

### 何を確定させるための検証か

011 章は対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` を導入し、

```
c(M)^{N_row} <= Z <= 2^M c(M)^{N_row},   c(M) = sup_{||x||=1} x^T W x
```

を**スペクトル定理を使わずに**示す。その結論と、証明の各段（実対称性・正定値性・成分の正値性・
`||Wx|| <= c||x||`・セクター分解）を数値で確かめる。

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
| 03 | check_03_sector_split.sage | `c(M) = max(c_+,c_-)`、`W P^{(±)} = V^{(±)} P^{(±)}`、最大が `(+)` セクターにあること | PASS | （run-log.txt 参照） |

## 備考

- **`c(M)` の数値評価には固有値を使っているが、本文の証明は固有値の存在を仮定していない。**
  本文では `c(M)` を Rayleigh 商の上限として定義し、上からの評価は半正定値双線型形式の
  Cauchy–Schwarz、下からの評価はモーメント列 `m_k = x^T W^k x` の対数凸性から導いている。
  数値側は「その上限が実際に最大固有値と一致する」ことを前提に確認しているだけで、
  本文の論理には影響しない。
- **最大が `(+)` セクターにあること**は check_03 で確認しているが、本文ではこの事実を使っていない。
  `W` の成分がすべて正なので Perron–Frobenius から期待されるとおりの結果である。
  この事実は次章（偶セクターの固有値）の指針として `docs/tasks/free-energy-roadmap` に記録した。

## 実行方法

```bash
for f in sagemath/check/044_claim_max_eigenvalue/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。

## 分割後の対応

プログラミングによる検証では check_03 の r_max が上限の最大値分解、r_rep が射影後の転送行列の表示を調べる。有限個のパラメータでの浮動小数点計算であり、一般証明ではない。BP=CP および射影子を移す各行に対応する独立した式変形検査は未実施。Leanでも射影後の表示は未形式化であり、偶セクター接続では仮定として残る。
