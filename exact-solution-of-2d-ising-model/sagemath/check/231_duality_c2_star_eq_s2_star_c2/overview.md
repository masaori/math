# SageMath Check: 231_duality_c2_star_eq_s2_star_c2

## 対象

**対象ラベル**: `duality_c2_star_eq_s2_star_c2` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: s₂* = 1/s₂、c₂* = c₂/s₂、c₂* = s₂*c₂

K₂* = −(1/2)log(tanh K₂) の定義から双対関係を確認する。sinh(2K₂)sinh(2K₂*) = 1 も見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_duality.sage` | 3 つの等式と双対の定義 | 50 | 2.665e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

この関係は `T_V_hatZ_hatY` の (1,2)/(2,1) 成分で c₂* と c₂ が入れ替わる理由になっている（既存の 017 でも従属的に確認されているが、こちらは独立したラベルの主張として張っている）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 231
```

実行ログは `sagemath/check/231_duality_c2_star_eq_s2_star_c2/logs/` に保存してある（この表の数値はそのログから取った）。
