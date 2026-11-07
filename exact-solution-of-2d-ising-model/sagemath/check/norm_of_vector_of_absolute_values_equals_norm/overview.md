# SageMath Check: norm_of_vector_of_absolute_values_equals_norm

## 対象

**対象ラベル**: `norm_of_vector_of_absolute_values_equals_norm` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_norm_of_vector_of_absolute_values_equals_norm`（`u_k := |x_k|` について `‖u‖ = ‖x‖`）
- 範囲: 主張の 4 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖 | `check_proof_lines.sage` | `n = 1, …, 6` で負の成分を含む決め打ちのベクトル 1 本と、符号を限らない有理数のベクトル 8 本（種は固定）の計 9 本ずつ（計 54 本）取り、鎖の各行の値が隣り合う行と等しいことと、3 行目で各項へ当てる `‖x_k‖^2 = |x_k|^2` を確かめる。否定コントロール 1 件（絶対値の二乗を取らずに成分を足すと `x = (1, -1)` で等号が崩れる例）。1 行目と 4 行目（`def_matrix_norm` を開く行）は定義どおりの同じ式なので、検算では恒等的に一致する | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 成分は QQ、根号は AA（実代数的数）で計算する。浮動小数点は使わない。
- 範囲外: `n ≥ 7`、選んだ以外の `x`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh norm_of_vector_of_absolute_values_equals_norm
```

実行ログは `logs/` に保存する。
