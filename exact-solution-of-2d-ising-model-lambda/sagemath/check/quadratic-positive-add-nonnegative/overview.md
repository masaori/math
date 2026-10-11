# SageMath Check: 正錐の非負係数条件どうしの和

**対象ラベル**: `claim_quadratic_positive_add_nonnegative`

本文の証明24行を一行一ファイルで検算する。`QQ` と `QQbar` の厳密計算を使い、
浮動小数点や実数体の順序は使わない。

## 標本と背理法の扱い

符号付き標本は $S=\{n/d\mid -4\le n\le4,\ 1\le d\le4\}$ の相異なる23個、
非負標本は $S_+=S\cap\mathbb Q_{\ge0}$ の12個である。
主張の仮定を満たす係数の組は、$S_+^4$ から零の入力組を除いた20,449組とする。
和の表示と正錐所属は $s^2=2$ の両根について確かめ、代数的数の表示を
入力係数ではなく最小多項式から取り戻す。

背理法の全仮定を同時に満たす数値事例は存在しない。成分取り出し・零元・加法単調性・
零和代入・反対称性・組の等号は、それぞれ下表の局所条件だけを満たす標本で検算する。
これらを背理法の全仮定の成立例とは数えない。背理法による一般の非零性は本文と Lean が保証し、
対応する Sage ファイルは結論を有限標本で確かめる。空の列挙を PASS とせず、各ファイルで件数も照合する。

## 行別の対応

| ファイル | 本文の行 | 局所条件 | 状態 | 確認件数 |
|---|---|---|---|---|
| `check_sum_representation.sage` | $\mathrm{rep}_s(\xi+\eta)=(a+a',b+b')$ | 非負標本の四係数・両入力組非零・s の両根 | PASS（2026-10-11） | 40,898 |
| `check_first_sum_nonnegative.sage` | $0\le a+a'$ | 二つの加数を非負標本から独立に取る | PASS（2026-10-11） | 144 |
| `check_second_sum_nonnegative.sage` | $0\le b+b'$ | 二つの加数を非負標本から独立に取る | PASS（2026-10-11） | 144 |
| `check_first_projection.sage` | $a+a'=0$ | a,b を符号付き標本から取り、a'=-a,b'=-b とする組の等号 | PASS（2026-10-11） | 529 |
| `check_second_projection.sage` | $b+b'=0$ | a,b を符号付き標本から取り、a'=-a,b'=-b とする組の等号 | PASS（2026-10-11） | 529 |
| `check_first_zero_identity.sage` | $a=a+0$ | 対象係数を符号付き標本から取る | PASS（2026-10-11） | 23 |
| `check_first_addition_monotone.sage` | $a+0\le a+a'$ | 対象係数は符号付き標本、他方の加数は非負標本 | PASS（2026-10-11） | 276 |
| `check_first_sum_zero.sage` | $a+a'=0$ | 対象係数を符号付き標本から取り、他方をその加法逆元とする | PASS（2026-10-11） | 23 |
| `check_first_antisymmetry.sage` | $a=0$ | 零以下かつ非負の標本（零のみ） | PASS（2026-10-11） | 1 |
| `check_first_prime_zero_identity.sage` | $a'=0+a'$ | 対象係数を符号付き標本から取る | PASS（2026-10-11） | 23 |
| `check_first_prime_addition_monotone.sage` | $0+a'\le a+a'$ | 対象係数は符号付き標本、他方の加数は非負標本 | PASS（2026-10-11） | 276 |
| `check_first_prime_sum_zero.sage` | $a+a'=0$ | 対象係数を符号付き標本から取り、他方をその加法逆元とする | PASS（2026-10-11） | 23 |
| `check_first_prime_antisymmetry.sage` | $a'=0$ | 零以下かつ非負の標本（零のみ） | PASS（2026-10-11） | 1 |
| `check_second_zero_identity.sage` | $b=b+0$ | 対象係数を符号付き標本から取る | PASS（2026-10-11） | 23 |
| `check_second_addition_monotone.sage` | $b+0\le b+b'$ | 対象係数は符号付き標本、他方の加数は非負標本 | PASS（2026-10-11） | 276 |
| `check_second_sum_zero.sage` | $b+b'=0$ | 対象係数を符号付き標本から取り、他方をその加法逆元とする | PASS（2026-10-11） | 23 |
| `check_second_antisymmetry.sage` | $b=0$ | 零以下かつ非負の標本（零のみ） | PASS（2026-10-11） | 1 |
| `check_second_prime_zero_identity.sage` | $b'=0+b'$ | 対象係数を符号付き標本から取る | PASS（2026-10-11） | 23 |
| `check_second_prime_addition_monotone.sage` | $0+b'\le b+b'$ | 対象係数は符号付き標本、他方の加数は非負標本 | PASS（2026-10-11） | 276 |
| `check_second_prime_sum_zero.sage` | $b+b'=0$ | 対象係数を符号付き標本から取り、他方をその加法逆元とする | PASS（2026-10-11） | 23 |
| `check_second_prime_antisymmetry.sage` | $b'=0$ | 零以下かつ非負の標本（零のみ） | PASS（2026-10-11） | 1 |
| `check_pair_zero.sage` | $(a,b)=(0,0)$ | 各成分が零である一組 | PASS（2026-10-11） | 1 |
| `check_sum_pair_nonzero.sage` | $(a+a',b+b')\ne(0,0)$ | 四係数を非負標本から取り、両入力組を非零とする | PASS（2026-10-11） | 20,449 |
| `check_positive_cone_membership.sage` | $\xi+\eta\in P_s$ | 非負標本の四係数・両入力組非零・s の両根 | PASS（2026-10-11） | 40,898 |

## 実行記録

- 2026-08-14: 既存の `sage check.sage` が成功。
- 2026-10-11: 行別24本104,884確認と既存統合検算3,744,225組がすべて成功。既存の `check.sage` は分子・分母の上限8の非負有理数を使う統合検算として保持する。

四係数の零への導出は本文と Lean 具体版に対応する。必要十分版は、非零性の証明に使う
第一の組の二係数だけを零とし、第二の組の零化だけに必要な零元則と加法単調性を仮定しない。

これは有限個の標本の厳密検算であり、一般の有理数についての証明は本文と Lean に置く。

## 実行方法

このディレクトリで実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```
