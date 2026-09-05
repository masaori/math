# 対数順序群と有限舞台の量の SageMath 検算

**対象ラベル**: `claim_binary_ca_logarithmic_gap_division_obstruction`

対象本文は `content/prime-logarithm.ts` と `content/binary-ca-logarithmic-counts.ts`。
プログラミングによる検証として、各式ペアを別ファイルで判定する。
本文の証明・所属・入力条件との対応の判断は LLMによる検証であり、件数だけでは保証しない。

## 全数範囲と限界

- 有理数は分子・分母が1〜12の全正分数を既約化して重複を除く。積・比は全対を扱う。
  素数係数は2,3,5,7,11,13で照合する。入力の分子分母の素因数は11以下で、積・比にも新素数は出ない。
  13は台の外の零の確認用である。
- ベクトルは台が{2,3,5}の部分集合、各係数が−1,0,1の全27個。群の公理と順序は全対・全三つ組。
  復元の正値性は係数−2〜2の全125個、除算の存在は−3〜3の全343個と乗数−3,−2,−1,1,2,3。
  解の一意性の有限照合は全27個の解候補の全対と同乗数で行う。
  有限台の一般性や全整数の消去律を有限走査で証明したとはしない。
- CAはセル数0,1,2、各セルの近傍が舞台全体である場合の全大域表を列挙する。
  配位から添字への全単射 index と、出力配位の各座標を返す局所真理値表を明示する。
  状態集合は二元のままで、二元体の線形構造は使わない。空舞台には空配位が一つある。
- 保存写像は各大域表について値域が{−1,0,1,2}に入る全整数値表を列挙し、全配位の保存条件で選ぶ。
  反復回数は1〜2×配位数の全範囲。繊維は直接反復の不動点を列挙して数える。
  この有限値域以外の全保存写像、全舞台、全回数を検査したとはしない。
- 二セルの自己近傍・恒等局所規則の反例は別に構成し、回数1〜16、帰納段階0〜16を照合する。
  この有限帰納段階の実行は全自然数の帰納法の形式証明を代替しない。
- 零・負の対数入力、零乗数の除算、非整除の除算、空繊維、片端のない隣接差、零総数は拒否を検査する。
  空の正値域や空和の行も削らない。順序は分子分母の交差積による整数比較であり、係数ごとの比較ではない。
- 全計算は有限集合・ZZ・QQ・素因数分解で閉じる。浮動小数点、実対数、実数・複素数への評価を使わない。
  Lean具体版は2026-09-06 04:12 tick、必要十分版と具体版への導出は05:12 tickに追加した。
  初等規則の有限校正は未達。必要十分版の一般化をこの有限範囲の検算だけで保証したとはしない。

## 定義ブロックの対応

有限台ベクトルとその演算は `check_finite_support_operations.sage`、素数指数と対数は
`check_rational_valuation_domain.sage` と `check_excluded_inputs.sage`、復元は
`check_reconstruction_domain.sage`、順序の定義は `check_order_translation_definition.sage` が担う。
CAの保存写像は `check_ca_local_tables.sage` と `check_conserved_tables.sage`、
繊維・状態数・正値域は `check_fiber_positive_domain.sage` と `check_partition_multiplicity.sage`、
エントロピー・隣接差・自由エントロピーはそれぞれ `check_entropy_domain.sage`、
`check_beta_domain.sage`、`check_free_count_domain.sage` が担う。
以下の主張の各式ペアと合わせ、両本文の全24ブロックへ対応させる。

## 本文の各段との対応と結果

| ファイル | 対象ラベル | 式ペア・判定 | 状態 | 結果 |
| --- | --- | --- | --- | --- |
| `check_associativity_expand.sage` | `claim_prime_vectors_abelian_group` | (a+b)+c の係数展開 | PASS | cases checked: 19683 |
| `check_associativity_integer.sage` | `claim_prime_vectors_abelian_group` | 整数の結合律 | PASS | cases checked: 19683 |
| `check_associativity_fold.sage` | `claim_prime_vectors_abelian_group` | a+(b+c) の係数へ戻す | PASS | cases checked: 19683 |
| `check_commutativity_expand.sage` | `claim_prime_vectors_abelian_group` | a+b の係数展開 | PASS | cases checked: 729 |
| `check_commutativity_integer.sage` | `claim_prime_vectors_abelian_group` | 整数の可換律 | PASS | cases checked: 729 |
| `check_commutativity_fold.sage` | `claim_prime_vectors_abelian_group` | b+a の係数へ戻す | PASS | cases checked: 729 |
| `check_zero_expand.sage` | `claim_prime_vectors_abelian_group` | (a+0)(p)=a(p)+0 | PASS | cases checked: 162 |
| `check_zero_integer.sage` | `claim_prime_vectors_abelian_group` | a(p)+0=a(p) | PASS | cases checked: 162 |
| `check_inverse_group_expand.sage` | `claim_prime_vectors_abelian_group` | (a+(-a))(p)=a(p)+(-a(p)) | PASS | cases checked: 162 |
| `check_inverse_group_integer.sage` | `claim_prime_vectors_abelian_group` | a(p)+(-a(p))=0 | PASS | cases checked: 162 |
| `check_inverse_group_fold.sage` | `claim_prime_vectors_abelian_group` | 0=0_Λ(p) | PASS | cases checked: 162 |
| `check_finite_support_operations.sage` | `def_prime_vector_additive_operations` | 和・逆元・整数倍の台と整数係数 | PASS | cases checked: 729 |
| `check_reconstruct_log_definition.sage` | `claim_prime_logarithm_inverse` | R(log q) の有限積への展開 | PASS | cases checked: 91 |
| `check_reconstruct_log_log_definition.sage` | `claim_prime_logarithm_inverse` | 対数の係数を素数指数へ | PASS | cases checked: 91 |
| `check_reconstruct_log_valuation.sage` | `claim_prime_logarithm_inverse` | 指数を分子分母の差へ | PASS | cases checked: 91 |
| `check_reconstruct_log_coprime.sage` | `claim_prime_logarithm_inverse` | 互いに素な分子分母の指数の正負分離 | PASS | cases checked: 91 |
| `check_reconstruct_log_factorization.sage` | `claim_prime_logarithm_inverse` | 素因数の積を分子分母へ復元 | PASS | cases checked: 91 |
| `check_reconstruct_log_reduced_fraction.sage` | `claim_prime_logarithm_inverse` | r/s=q | PASS | cases checked: 91 |
| `check_log_reconstruct_definition.sage` | `claim_prime_logarithm_inverse` | log(R(a))(p)=v_p(R(a)) | PASS | cases checked: 162 |
| `check_log_reconstruct_factorization.sage` | `claim_prime_logarithm_inverse` | 復元分数の素因数指数 | PASS | cases checked: 162 |
| `check_log_reconstruct_sign_cases.sage` | `claim_prime_logarithm_inverse` | 正・負・零の係数の復元 | PASS | cases checked: 162 |
| `check_reconstruction_domain.sage` | `def_prime_vector_reconstruction` | 復元の正値性・既約性・空台・台の外の零 | PASS | cases checked: 125 |
| `check_rational_valuation_domain.sage` | `def_positive_rational_prime_valuation` | 既約表示と対数の有限台 | PASS | cases checked: 91 |
| `check_product_log.sage` | `claim_prime_logarithm_product` | log(qt)(p)=v_p(qt) | PASS | cases checked: 49686 |
| `check_product_reduced_product.sage` | `claim_prime_logarithm_product` | 積を既約表示へ | PASS | cases checked: 49686 |
| `check_product_exact_quotient.sage` | `claim_prime_logarithm_product` | 整除による素数指数の減法 | PASS | cases checked: 49686 |
| `check_product_factor_product.sage` | `claim_prime_logarithm_product` | 整数積の素数指数の加法 | PASS | cases checked: 49686 |
| `check_product_cancel_gcd.sage` | `claim_prime_logarithm_product` | 共通因子の指数の消去 | PASS | cases checked: 49686 |
| `check_product_valuation.sage` | `claim_prime_logarithm_product` | 二つの有理数の指数へ | PASS | cases checked: 49686 |
| `check_product_log_coefficients.sage` | `claim_prime_logarithm_product` | 二つの対数係数へ | PASS | cases checked: 49686 |
| `check_product_add_coefficients.sage` | `claim_prime_logarithm_product` | 対数の和の係数へ | PASS | cases checked: 49686 |
| `check_reciprocal_log.sage` | `claim_prime_logarithm_ratio` | 逆数の対数係数 | PASS | cases checked: 546 |
| `check_reciprocal_valuation.sage` | `claim_prime_logarithm_ratio` | 逆数の既約分数指数 | PASS | cases checked: 546 |
| `check_reciprocal_subtract.sage` | `claim_prime_logarithm_ratio` | 整数の減法の符号反転 | PASS | cases checked: 546 |
| `check_reciprocal_original_valuation.sage` | `claim_prime_logarithm_ratio` | 元の有理数の指数 | PASS | cases checked: 546 |
| `check_reciprocal_original_log.sage` | `claim_prime_logarithm_ratio` | 元の対数係数 | PASS | cases checked: 546 |
| `check_reciprocal_negation.sage` | `claim_prime_logarithm_ratio` | ベクトルの符号反転 | PASS | cases checked: 546 |
| `check_ratio_division.sage` | `claim_prime_logarithm_ratio` | q/t=qt^{-1} の対数 | PASS | cases checked: 8281 |
| `check_ratio_product.sage` | `claim_prime_logarithm_ratio` | 積の対数公式 | PASS | cases checked: 8281 |
| `check_ratio_reciprocal.sage` | `claim_prime_logarithm_ratio` | 逆数の対数を符号反転へ | PASS | cases checked: 8281 |
| `check_ratio_difference.sage` | `claim_prime_logarithm_ratio` | 差の定義 | PASS | cases checked: 8281 |
| `check_reconstruct_sum_inverse.sage` | `claim_prime_logarithm_ordered_group` | a,c を log R で置換 | PASS | cases checked: 729 |
| `check_reconstruct_sum_product.sage` | `claim_prime_logarithm_ordered_group` | 対数の和を積の対数へ | PASS | cases checked: 729 |
| `check_reconstruct_sum_inverse_again.sage` | `claim_prime_logarithm_ordered_group` | R log の相殺 | PASS | cases checked: 729 |
| `check_order_translation_definition.sage` | `claim_prime_logarithm_ordered_group` | 加法後の順序の定義 | PASS | cases checked: 19683 |
| `check_order_translation_product.sage` | `claim_prime_logarithm_ordered_group` | 復元の積公式 | PASS | cases checked: 19683 |
| `check_order_translation_positive_cancel.sage` | `claim_prime_logarithm_ordered_group` | 正の因子の消去 | PASS | cases checked: 19683 |
| `check_order_translation_definition_back.sage` | `claim_prime_logarithm_ordered_group` | 元の順序の定義 | PASS | cases checked: 19683 |
| `check_order_log_definition.sage` | `claim_prime_logarithm_ordered_group` | 対数の順序を復元値で比較 | PASS | cases checked: 8281 |
| `check_order_log_inverse.sage` | `claim_prime_logarithm_ordered_group` | 復元と対数の相殺 | PASS | cases checked: 8281 |
| `check_total_order.sage` | `claim_prime_logarithm_ordered_group` | 反射・反対称・推移・全比較 | PASS | cases checked: 19683 |
| `check_division_necessity.sage` | `claim_prime_vector_integer_division` | 整数倍の各係数は乗数で割り切れる | PASS | cases checked: 2058 |
| `check_division_sufficiency.sage` | `claim_prime_vector_integer_division` | 整除条件から台の内外で解を構成 | PASS | cases checked: 2058 |
| `check_division_uniqueness.sage` | `claim_prime_vector_integer_division` | 二解の係数等号と非零整数の消去 | PASS | cases checked: 4374 |
| `check_excluded_inputs.sage` | `def_prime_logarithm` | 零・負有理数と零除算を拒否 | PASS | cases checked: 3 |
| `check_ca_local_tables.sage` | `def_binary_ca_integer_conserved_observable` | 全近傍の局所真理値表から大域表を復元 | PASS | cases checked: 261 |
| `check_conserved_tables.sage` | `def_binary_ca_integer_conserved_observable` | 全配位の保存条件と反復中の保存 | PASS | cases checked: 28088 |
| `check_fiber_positive_domain.sage` | `def_binary_ca_positive_fiber_levels` | 正状態数の集合は不動点集合の像 | PASS | cases checked: 28088 |
| `check_fiber_cover_disjoint.sage` | `claim_binary_ca_fiber_count_partition` | 繊維の被覆と相異なる繊維の非交叉 | PASS | cases checked: 28088 |
| `check_partition_multiplicity.sage` | `claim_binary_ca_fiber_count_partition` | 状態数を繊維の元数へ | PASS | cases checked: 28088 |
| `check_partition_disjoint_union.sage` | `claim_binary_ca_fiber_count_partition` | 互いに素な有限合併の元数 | PASS | cases checked: 28088 |
| `check_partition_cover.sage` | `claim_binary_ca_fiber_count_partition` | 合併を不動点集合へ | PASS | cases checked: 28088 |
| `check_partition_fixed_count.sage` | `claim_binary_ca_fiber_count_partition` | 不動点集合の元数を総数へ | PASS | cases checked: 28088 |
| `check_entropy_domain.sage` | `def_binary_ca_fiber_logarithmic_entropy` | 非空繊維の対数を復元し空繊維を拒否 | PASS | cases checked: 28088 |
| `check_beta_definition.sage` | `claim_binary_ca_unit_difference_ratio` | β=S(u+1)-S(u) | PASS | cases checked: 13056 |
| `check_beta_entropy.sage` | `claim_binary_ca_unit_difference_ratio` | 両端のエントロピーを対数へ | PASS | cases checked: 13056 |
| `check_beta_log_ratio.sage` | `claim_binary_ca_unit_difference_ratio` | 対数の差を比の対数へ | PASS | cases checked: 13056 |
| `check_beta_rational_ratio.sage` | `claim_binary_ca_unit_difference_ratio` | 分母一の比を状態数比へ | PASS | cases checked: 13056 |
| `check_beta_domain.sage` | `def_binary_ca_unit_logarithmic_difference` | 両端が正の隣接値だけを受理 | PASS | cases checked: 28088 |
| `check_free_count_domain.sage` | `def_binary_ca_logarithmic_free_count` | 正総数の自由エントロピーと零総数の拒否 | PASS | cases checked: 2066 |
| `check_free_bound_rational.sage` | `claim_binary_ca_logarithmic_free_count_bound` | 1 ≤ q_F(n) ≤ 2^|V|/1 | PASS | cases checked: 2066 |
| `check_free_bound_log.sage` | `claim_binary_ca_logarithmic_free_count_bound` | 正有理数の上界を対数順序へ移す | PASS | cases checked: 2066 |
| `check_free_fibers_definition.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | Φ の定義 | PASS | cases checked: 26400 |
| `check_free_fibers_rational_input.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | q_F(n) を Z_n/1 へ | PASS | cases checked: 26400 |
| `check_free_fibers_partition.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | Z_n を繊維状態数の和へ | PASS | cases checked: 26400 |
| `check_gap_local_global_definition.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | (Fx)(z)=f_z(x の制限) | PASS | cases checked: 8 |
| `check_gap_local_local_definition.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 局所恒等規則の適用 | PASS | cases checked: 8 |
| `check_gap_local_restriction.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 制限写像の評価 | PASS | cases checked: 8 |
| `check_gap_conserved.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 反例の保存写像と帰納基底 | PASS | cases checked: 4 |
| `check_gap_induction_recursion.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | F^(n+1)x=F(F^n x) | PASS | cases checked: 68 |
| `check_gap_induction_hypothesis.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 帰納仮定を代入 | PASS | cases checked: 68 |
| `check_gap_induction_identity.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | Fx=x | PASS | cases checked: 68 |
| `check_gap_fibers.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 反例の四配位・繊維状態数1,2,1・正値域 | PASS | cases checked: 16 |
| `check_gap_difference_entropy.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 反例の差を状態数の対数へ | PASS | cases checked: 16 |
| `check_gap_difference_counts.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 四配位の個数を代入 | PASS | cases checked: 16 |
| `check_gap_difference_ratio.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 比の対数公式 | PASS | cases checked: 16 |
| `check_gap_difference_arithmetic.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 正有理数の算術 | PASS | cases checked: 16 |
| `check_gap_coefficient_log.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 素数2の対数係数 | PASS | cases checked: 16 |
| `check_gap_coefficient_factorization.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 2の素因数分解の指数は1 | PASS | cases checked: 16 |
| `check_gap_obstruction.sage` | `claim_binary_ca_logarithmic_gap_division_obstruction` | 非整除の証人と空の隣接定義域 | PASS | cases checked: 16 |
| `check_domain_coverage.sage` | `def_binary_ca_positive_fiber_levels` | 全数範囲と空・非空・未定義の枝の非空性 | PASS | 保存3,528組、空1,688組、非空26,400組、隣接13,056組、欠落155,472組 |

## 実行記録と再現

2026-09-06 05:12 tickのプログラミングによる検証でも全91本が終了0・RESULT: PASS。
90本の各式ペアの実行件数が上表と一致し、入力枝を照合する残り一本の出力も前tickと一致した。
結果は `/tmp/ca-tick-20260906-0512-sage/results.json` と同ディレクトリの各ログ。
同tickで必要十分版と具体版への導出を追加した。一般の証明はLean、本文との手順の対応判断は
LLMによる検証であり、この有限掃引の成功から一般性を結論していない。


2026-09-06 03:12 tick のプログラミングによる検証で、全91本が終了コード0・RESULT: PASS。
各91件の結果は上表に残す。90本の逐次実行の集計は
`/tmp/ca-tick-20260906-0312-sage/results.json`、入力枝の集計は同ディレクトリの
`check_domain_coverage.sage.log`。共通定義へ計算結果のキャッシュを加える前に読み込み済みだった
先頭六本も現行定義で再実行し、件数・結果が一致した（`recheck.json`、`recheck-domain.json`）。
判定条件・全数範囲は変更していない。検算の失敗はなかった。
CAの写像・回数2,066組のうち正総数1,680組、零総数386組。
保存写像3,528組から得た写像・保存写像・回数28,088組のうち、正値域が非空26,400組、空1,688組。
これらは入力の種類ごとの件数であり、異なる数学的成果の件数ではない。

リポジトリ直下から各ファイルを独立に実行できる。

```sh
set -e
for file in cellular-automata-statistical-mechanics/sagemath/check/logarithmic-counts/check_*.sage; do
  sage "$file"
done
node cellular-automata-statistical-mechanics/sagemath/tools/verify-check-linkage.ts
```

LLMによる検証では、本文二本の各段と検算式を照合し、有限範囲の外に結論を拡張していないこと、
空集合を対数へ渡さないこと、反例の自己近傍規則を全近傍の全数列挙と分けたこと、
分割計数に保存条件が不要なことを確認した。新主張のLean二版・導出は次層である。

## Lean具体版への接続（2026-09-06 04:12 tick）

`lean/CellularAutomata/PrimeLogarithm.lean` と `BinaryCALogarithmicCounts.lean` に
本文ラベルと定理の対応を記した。新二ファイルの60定理を全体ビルドと公理検査へ登録した。
有限範囲の検算と一般の形式証明を区別し、必要十分版と導出は未達として残す。
今回の再実行も全91本が終了0・RESULT: PASS。90本の実行件数は上表と一致し、
残り1本の入力枝の網羅性判定も成功した。個別ログと集計は
`/tmp/ca-tick-20260906-0412-sage/`。Lean全体と新60定理の公理検査も終了0。
結果の詳細は状態台帳の同tick項へ記録した。
