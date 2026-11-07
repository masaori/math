# SageMath Check: real_matrix_fixed_vector_stays_fixed_after_normalization

## 対象

**対象ラベル**: `real_matrix_fixed_vector_stays_fixed_after_normalization` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_matrix_fixed_vector_stays_fixed_after_normalization`（`P ∈ Mat(n,ℝ)`、`v ≠ 0`、`v̂_k := v_k/‖v‖` について、すべての `i` で `(Pv)_i = v_i` なら `(Pv̂)_i = v̂_i`）
- 範囲: 証明の準備の 2 行の鎖（`v̂_k = v_k/‖v‖ = (1/‖v‖)v_k`）と主張の 4 行の鎖。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の 2 行と主張の 4 行の鎖 | `check_proof_lines.sage` | `n = 1, …, 5` で、隣り合う成分を入れ替える置換行列とそれで動かない負の成分を含む `v` の 1 組と、零でない有理数の `v` と、乱数の有理数の行列の 1 列を直して `Pv = v` にした `P` の 6 組（種は固定）の計 7 組ずつ（計 35 組）取り、仮定 `(Pv)_i = v_i` を確かめたうえで、準備の各 `k` の 2 段と主張の各 `i` の 4 段で隣り合う行の値が等しいことを確かめる（630 段）。否定コントロール 2 件（仮定を満たさない `P = 2I` では `(Pv̂)_1 ≠ v̂_1`、2 行目の `1/‖v‖` を `1/‖v‖^2` にした誤った行が 1 行目と一致しない） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 成分は QQ、根号と商は AA（実代数的数）で計算する。浮動小数点は使わない。
- 範囲外: `n ≥ 6`、選んだ以外の `(P, v)`。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_matrix_fixed_vector_stays_fixed_after_normalization
```

実行ログは `logs/` に保存する（2026-11-07）。
