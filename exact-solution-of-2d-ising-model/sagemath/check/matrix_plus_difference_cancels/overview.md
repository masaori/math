# SageMath Check: matrix_plus_difference_cancels

## 対象

**対象ラベル**: `matrix_plus_difference_cancels` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_plus_difference_cancels`（行列 A と差 B − A の和は B）
- 範囲: 主張 `A + (B - A) = B` と、証明の `(i,k)` 成分の七行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の七行 | `check_component_chain.sage` | 各行を本文の和・差・符号反転の定め方どおりに組み、隣り合う項が等しい | **PASS** | 9 通りの大きさで 252 段 |
| 主張そのもの | 同上 | 本文の式で組んだ `A + (B - A)` と Sage 組み込みの和・差（独立な経路）が `B` に一致する。否定コントロールとして `A + (A - B)` は `B` に一致しない | **PASS** | 9 通りの大きさで厳密等号、否定コントロール 9 通り |

## 計算の帰属と範囲

`A, B` の成分（`m, p ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。
添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_plus_difference_cancels
```

実行ログは `sagemath/check/matrix_plus_difference_cancels/logs/` に保存する（2026-11-02）。
