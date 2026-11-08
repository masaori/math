# SageMath Check: square_of_real_number_is_product

## 対象

**対象ラベル**: `square_of_real_number_is_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_square_of_real_number_is_product`（`r^2 = rr`）
- 範囲: 主張と、証明の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖（`r^2 = r^1 r = (r^0 r) r = (1 r) r = r r`） | `check_proof_lines.sage` | QQ と AA の 12 点で、冪を `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組み、各行の等号を厳密に。Sage の `**` とも比べる | **PASS** | 厳密（等号 48 個） |
| 否定コントロール | 同上 | `a^0` を `0` に取り違えると、`r ≠ 0` の 11 点で 3 行目が崩れる | **PASS** | 11 件 |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh square_of_real_number_is_product
```

実行ログは `logs/` に保存する（2026-11-08、SageMath 10.9）。
