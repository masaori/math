# SageMath 検算: 有限離散対称性と連続対称性の境界

## 対象

**対象ラベル**: `claim_binary_ca_real_parameter_symmetry_action_trivial`

- 併せて検証するラベル: `claim_binary_ca_commuting_configuration_symmetries_finite_group`、
  `claim_binary_ca_integer_conserved_observables_additive_group`、
  `claim_binary_ca_symmetry_pullback_preserves_conserved_observables`。
- 可換置換群の閉性、整数値保存写像の加法閉性、引き戻し作用の保存性と作用律、
  実数一径数作用の自明性に使う有限群の冪等式を段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_commuting_symmetry_group.sage` | 大域写像と可換する全単射の恒等写像・合成・逆写像に関する閉性 | PASS | 全 288 大域写像、積 1,763 件、逆元 505 件で成立 |
| `check_conserved_additive_group.sage` | 値域を負一・零・一に制限して列挙した保存写像について、零・加法・符号反転後の保存性 | PASS | 全 288 大域写像、和 30,384 件、符号反転 2,028 件で成立 |
| `check_pullback_action.sage` | 引き戻し後の保存性、恒等置換の単位律、置換の積との整合律 | PASS | 保存性 375 件、単位律 180 件、積との整合律 1,317 件で成立 |
| `check_real_action_triviality.sage` | 各有限対称群で全要素の位数が群位数の階乗を割ることに対応する冪等式 | PASS | 全 288 大域写像、有限群冪等式 505 件で成立 |

## 範囲と限界

- 配位集合は元数一から四、大域写像は各元数で全写像を列挙する。保存写像の入力はその有限集合、
  値域は検算用に整数の負一・零・一へ制限する。加法・符号反転後の値がこの検算用範囲を外れても、
  整数値写像として保存条件を直接判定する。
- 引き戻しの作用律は、計算量を有限に明示するため配位集合の元数一から三で全数検査する。
  これは明示した有限範囲のプログラミングによる検証であり、一般証明は構造化記述にある。
- 実数一径数作用の自明性では、有限対称群側の `g^m=id` を厳密な置換表で検査する。
  `t=m(t/m)` は実数加法群の整除可能性であり、浮動小数点の標本検査には置き換えない。
  実数脱出は本文のパラメータ集合と除算だけにあり、位相、極限、微分、複素数体は扱わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-discrete-continuous-symmetry-boundary/check_*.sage; do sage "$file"; done
```
