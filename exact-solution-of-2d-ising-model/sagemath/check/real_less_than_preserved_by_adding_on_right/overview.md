# SageMath Check: real_less_than_preserved_by_adding_on_right

## 対象

**対象ラベル**: `real_less_than_preserved_by_adding_on_right` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_less_than_preserved_by_adding_on_right`（`ℝ` で `x < y` なら `x + c < y + c`）
- 範囲: 主張と、証明の `x + c ≤ y + c` の行、`x + c = y + c` を仮定した背理の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 背理の鎖 `x = x + 0 = x + (c + (−c)) = (x + c) + (−c) = (y + c) + (−c) = y + (c + (−c)) = y + 0 = y` | `check_proof_lines.sage` | `QQ[x, y, c, nc]`（`nc` は `−c`）で、等号は恒等的、またはイデアル `(c + nc)`・`(x + c − (y + c))` に入る。両端の差は二つの和のイデアルに入る | **PASS** | 厳密 7 段と両端 |
| `x + c ≤ y + c`（`≤` と加法の両立、`t → c`） | 同上 | 有理数の標本で公理の形 | **PASS** | 75 件 |
| 主張 `x < y ⇒ x + c < y + c` と `<` の定義の両向き | 同上 | `QQ` と `AA` の標本 | **PASS** | 101 件 |
| 否定コントロール | 同上 | 仮定または加法の逆元を外すと鎖が閉じない。`x < y` を外すと主張は偽 | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: `QQ`・`AA` と多項式環 `QQ[x, y, c, nc]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: 不等号の段は有理数の標本で公理の形を確かめるだけで、ℝ の順序体の公理からの証明ではない。
  検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_less_than_preserved_by_adding_on_right
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
