# SageMath Check: 二次体の正錐を代数的数へ写した三分法

**対象ラベル**: `claim_quadratic_positive_cone_ambient_trichotomy`

**実行日**: 2026-11-17

## 確認内容

有理係数対から作った $z=a+bs\in\overline{\mathbb Q}$ について、包含後の $-z$ が係数対 $(-a,-b)$ の値に等しく、零・正・負の三条件がちょうど一つ成り立つことを `QQ` と `QQbar` で厳密に確かめる。有限標本の検算であり、全称命題の証明は Lean が担う。

| ファイル | ステータス | 結果 |
|---|---|---|
| `check.sage` | PASS | 有理係数対 1,089 組で成立 |
