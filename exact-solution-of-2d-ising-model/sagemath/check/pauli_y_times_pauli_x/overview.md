# SageMath Check: pauli_y_times_pauli_x

## 対象

**対象ラベル**: `pauli_y_times_pauli_x`

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`
- ブロック: `Z_Y_anticommutation_claim_pauli_y_times_pauli_x`（σ^yσ^x = (−i)σ^z。σ^x, σ^y, σ^z は pauli_matrix_products）
- 範囲: 証明の鎖の 7 行の全てと主張。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 1 行目（pauli_matrix_products の成分表示） | `check_chain.sage` | 厳密（QQ(i)）。主張の左辺の積と成分表示の積を mat_mult の成分の式で組んで比べる |
| 2 行目（mat_mult） | `check_chain.sage` | 厳密 |
| 3〜5 行目（ℂ の積: (−i)·1、(−i)·0、(−i)·(−1)） | `check_chain.sage` | 厳密。ℂ の積は全て definition_of_cc の積を QQ の対で計算した値（`cc_mul`）で組み、個々の積の値も別に確かめる |
| 6 行目（def_matrix_scalar_multiple） | `check_chain.sage` | 厳密。スカラー倍を成分の式で組む |
| 7 行目（pauli_matrix_products） | `check_chain.sage` | 厳密 |

主張は Sage の行列積 `*` とスカラー倍の独立な経路でも確かめる。否定コントロール: 右辺の符号を (+i) にしたもの、左辺の積の順序を入れ替えたものは外れる。
浮動小数点は使わない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 鎖の 7 行と ℂ の積と主張 | 実行済み | PASS（等号 11 件、否定コントロール 2 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh pauli_y_times_pauli_x
```
