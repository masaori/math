# SageMath Check: def_real_matrix_of_real_entry_matrix

## 対象

**対象ラベル**: `def_real_matrix_of_real_entry_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_definition_real_matrix_of_real_entry_matrix`（成分がすべて実数の複素行列から実数の行列への写像 ϱ）
- 範囲: `w_pq(B)` がただ一つに定まること、`((B_ℝ)_pq)_ℂ = B_pq`

## 証明の行との対応

| 定義の段 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `w_pq(B)` の存在と一意性、`((B_ℝ)_pq)_ℂ = B_pq` | `check_definition.sage` | 成分が QQ と AA の 7 点から取った 1〜4 行 1〜4 列の行列 40 個を QQbar へ埋め込み、ϱ で戻した各成分で等式と一意性を、戻した行列が元の行列に一致することを厳密に。虚部が 0 でない成分を持つ行列 1 件が定義域に入らないこと（否定コントロール） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ・AA・QQbar だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の行列。点での検算は証明ではなく、定義の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_real_matrix_of_real_entry_matrix
```

実行ログは `logs/` に保存する。
