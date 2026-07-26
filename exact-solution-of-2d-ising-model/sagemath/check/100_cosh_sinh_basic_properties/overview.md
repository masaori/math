# SageMath Check: 100_cosh_sinh_basic_properties

## 対象

**対象ラベル**: `cosh_sinh_basic_properties` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`

- 範囲: (1) cosh−sinh=exp(−x) 等、(2) cosh²−sinh²=1、(3) x>0 で cosh>sinh>0、(4) a,b>0 で a²=b² ⟺ a=b

実数の指数関数の定義式から cosh, sinh を組み直したものと、標準ライブラリの cosh, sinh を突き合わせる。(4) は正値性の仮定が本当に必要であること（(−a)²=a² だが −a≠a）も確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_cosh_sinh.sage` | (1)〜(4) の全項目と、(3)(4) の仮定の必要性 | 477 | 1.206e-12 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

平方根は `_prelude.sage` の二分法による構成（`sqrt_nonneg`）を使い、標準ライブラリの sqrt に依存しない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 100
```

実行ログは `sagemath/check/100_cosh_sinh_basic_properties/logs/` に保存してある（この表の数値はそのログから取った）。
