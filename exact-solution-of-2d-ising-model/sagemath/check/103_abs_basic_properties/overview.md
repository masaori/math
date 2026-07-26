# SageMath Check: 103_abs_basic_properties

## 対象

**対象ラベル**: `abs_basic_properties` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: (1) |z|=√(x²+y²)、(2) |z|²=x²+y²、(3) |z|=0⟺z=0、(4) 乗法性、(5) 三角不等式、(6) 実数の包含との整合

|z| := pr₁(φ_polar(z)) という定義どおりの経路（`_prelude.sage` で φ_polar を場合分けから組んだもの）と、成分から直接計算した √(x²+y²) を突き合わせる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_abs.sage` | (1)〜(6) と三角不等式の等号（同じ偏角） | 1493 | 5.393e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

サンプルには 0、実軸上、虚軸上、各象限、1e-9 スケール、1e6 スケール、単位円上を 15° 刻みで含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 103
```

実行ログは `sagemath/check/103_abs_basic_properties/logs/` に保存してある（この表の数値はそのログから取った）。
