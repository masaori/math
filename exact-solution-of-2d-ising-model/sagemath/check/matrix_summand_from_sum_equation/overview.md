# SageMath Check: matrix_summand_from_sum_equation

## 対象

**対象ラベル**: `matrix_summand_from_sum_equation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_summand_from_sum_equation`（和の等式から右の項を差で表す）
- 範囲: 主張 `A + B = C ⇒ B = C - A` と、証明の `(i,k)` 成分の八行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の八行 | `check_component_chain.sage` | 仮定を満たす `C := A + B` で各行を組み、隣り合う項が等しい。否定コントロールとして、不定元の `C` では仮定を使う行だけが等号を外れる | **PASS** | 9 通りの大きさで 288 段、否定コントロール 36 行 |
| 主張そのもの | 同上 | 本文の差の式で組んだ `C - A` と Sage 組み込みの差（独立な経路）が `B` に一致する | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A, B, C` の成分（`m, p ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。
添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_summand_from_sum_equation
```

実行ログは `sagemath/check/matrix_summand_from_sum_equation/logs/` に保存する（2026-11-02）。
