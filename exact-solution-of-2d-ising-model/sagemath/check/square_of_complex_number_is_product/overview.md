# SageMath Check: square_of_complex_number_is_product

## 対象

**対象ラベル**: `square_of_complex_number_is_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_square_of_complex_number_is_product`（`z^2 = zz`）
- 範囲: 主張と、証明の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖（`z^2 = z^1 z = (z^0 z) z = (1_ℂ z) z = z z`） | `check_proof_lines.sage` | QQbar の 11 点で、冪を `def_power_of_complex_number` どおり `z^0 := 1_ℂ`、`z^{m+1} := z^m z` で組み、各行の等号を厳密に。Sage の `**` とも比べる | **PASS** | 厳密（等号 44 個） |
| 否定コントロール | 同上 | `z^0` を `0` に取り違えると、`z ≠ 0` の 10 点で 3 行目が崩れる | **PASS** | 10 件 |

## 計算の帰属と範囲

- **厳密**: QQbar（代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh square_of_complex_number_is_product
```

実行ログは `logs/` に保存する（2026-11-10、SageMath 10.9）。
