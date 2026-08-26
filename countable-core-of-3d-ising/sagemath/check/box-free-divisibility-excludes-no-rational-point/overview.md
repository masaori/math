# SageMath Check: 箱に依存しない整除だけでは分子を排除できない

## 対象

**対象ラベル**: `claim_box_free_divisibility_excludes_no_rational_point`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 任意の正の自然数 `a` に対する `c=a+1` の構成と `a | 2(c-1)`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | `c=a+1` が正であり、`2(c-1)=2a` から `a | 2(c-1)` が従うことを確認する | PASS | `ZZ` 上の正の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。`RESULT: PASS`。

## 実行方法

```bash
sage sagemath/check/box-free-divisibility-excludes-no-rational-point/check.sage
```
