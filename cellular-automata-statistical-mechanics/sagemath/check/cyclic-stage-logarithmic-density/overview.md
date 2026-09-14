# SageMath 検算: 有限巡回段階の対数順序群値と舞台サイズ規格化の境界

## 対象

**対象ラベル**: `claim_cyclic_stage_shift_logarithmic_density_obstruction`

- 併せて検証するラベル: `def_cyclic_stage_logarithmic_density_domain`、
  `def_cyclic_stage_shift_rule_family`。
- 一方向シフトの不動点の全数分類、状態数二の素数係数、舞台サイズによる整除障害を、
  本文の証明段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_shift_fixed_point_classification.sage` | 一方向シフトの不動点が二つの定値配位を尽くすこと | PASS | 舞台サイズ 1..16 の全 131,070 配位で同値 |
| `check_shift_logarithmic_prime_coefficient.sage` | 状態数二の素因数指数ベクトルと素数二の係数一 | PASS | 素数二の係数一と積への復元を確認 |
| `check_stage_size_divisibility_obstruction.sage` | 舞台サイズによる群内除算が一セル段階だけで定義できること | PASS | 舞台サイズ 1..128 で定義域は一セル段階だけ |

## 範囲と限界

- 不動点分類は舞台サイズ 1..16 の全 131,070 配位を検査する。
- 整除障害は舞台サイズ 1..128 で検査し、対数順序群の素数二の係数一を割れるのが
  舞台サイズ一だけであることを判定する。
- これは明記した有限範囲のプログラミングによる検証であり、一般証明ではない。
  一般の場合の根拠は構造化記述にある。
- 有限集合、自然数、整数、有限台整数ベクトルだけを使う。未定義の商に既定値を置かず、
  浮動小数点、実対数、実数除算、極限、実数体、複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/cyclic-stage-logarithmic-density/check_*.sage; do sage "$file"; done
```
