# SageMath Check: matrix_conjugation_preserves_difference

## 対象

**対象ラベル**: `matrix_conjugation_preserves_difference` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_matrix_conjugation_preserves_difference`（行列の共役は差を保つ）
- 範囲: 主張 `T_B(X - W) = T_B(X) - T_B(W)` と、証明の四行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の四行 | `check_chain.sage` | 鎖の項を各行に書かれた式どおりに組み、隣り合う項が行列として等しい | **PASS** | `n = 1, 2, 3` で厳密等号 |
| 主張そのもの | 同上 | Sage 組み込みの演算（独立な経路）と比べる。否定コントロールとして、差を和にした `T_B(X) + T_B(W)` とは一致しないことも確かめる | **PASS** | `n = 1, 2, 3` で厳密等号 |

## 計算の帰属と範囲

`B`、`B^{-1}` と行列の成分（`n ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
`T_B(X) = (BX)B^{-1}` の `B^{-1}` は、鎖のどの行も `B^{-1}B = I` を使わないので、`B` と独立な不定元の行列に置いた。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

差・符号反転・和・積は共通の準備 `_shared/matrix_operations_by_definition.sage`・`_shared/matrix_negation_and_difference_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの演算とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_conjugation_preserves_difference
```

実行ログは `sagemath/check/matrix_conjugation_preserves_difference/logs/` に保存する（2026-11-02）。
