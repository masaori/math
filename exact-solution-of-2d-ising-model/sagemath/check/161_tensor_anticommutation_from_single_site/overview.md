# SageMath Check: 161_tensor_anticommutation_from_single_site

## 対象

**対象ラベル**: `tensor_anticommutation_from_single_site` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`

- 範囲: 1 サイトだけ反可換ならテンソル積全体が反交換

第 j サイトに反可換な組、他サイトに可換な組を置いて確認する。さらに**仮定を崩した場合**（全サイトで反可換、M が偶数）には結論が破れることも確認しており、「反可換なサイトがちょうど 1 つ」という仮定が本質的であることが分かる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_single_site.sage` | 主張と仮定の必要性 | 28 | 3.553e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 161
```

実行ログは `sagemath/check/161_tensor_anticommutation_from_single_site/logs/` に保存してある（この表の数値はそのログから取った）。
