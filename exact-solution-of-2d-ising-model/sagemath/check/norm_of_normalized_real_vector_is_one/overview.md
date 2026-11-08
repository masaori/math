# SageMath Check: norm_of_normalized_real_vector_is_one

## 対象

**対象ラベル**: `norm_of_normalized_real_vector_is_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_norm_of_normalized_real_vector_is_one`（`v ≠ 0`、`v̂_k := v_k/‖v‖` について `‖v̂‖ = 1`）
- 範囲: 証明の準備（`‖v‖ > 0`、`‖v‖^2 = ‖v‖‖v‖` と `‖x‖^2 = Σ|x_k|^2`）と主張の 11 行の鎖。二乗は `def_power_of_real_number` の冪として組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備と 11 行の鎖 | `check_proof_lines.sage` | `n = 1, …, 6` で負の成分を含む決め打ちのベクトル 1 本と、符号を限らない零でない有理数のベクトル 8 本（種は固定）の計 9 本ずつ（計 54 本）取り、準備の `‖v‖ ≥ 0`・`‖v‖ ≠ 0`・`‖v‖ > 0`・`‖v‖^2 = ‖v‖‖v‖ > 0`・`‖v‖^2 ≠ 0` と `‖v‖^2 = (√Σ\|v_k\|^2)^2 = Σ\|v_k\|^2` の 2 段 と、鎖の各行の値が隣り合う行と等しいことと、4〜6 行目で各項へ当てる `(a/b)^2 = (a/b)(a/b) = (1/(bb))(aa) = (1/b^2)a^2` と最後の行の `1^2 = 1` を確かめる（1647 段）。否定コントロール 1 件（`‖v‖^2` で割ると `v = (3, 4)` でノルムが 1 にならない例） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 成分は QQ、根号と商は AA（実代数的数）で計算する。浮動小数点は使わない。
- 範囲外: `n ≥ 7`、選んだ以外の `v`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh norm_of_normalized_real_vector_is_one
```

実行ログは `logs/` に保存する。
