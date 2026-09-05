# 正の不動点数の定義域の SageMath 検算

**対象ラベル**: `claim_positive_count_domain_finitely_decidable`

本文は `structured-latex/content/positive-fixed-point-count-domain.ts` と `binary-ca-positive-count-domain.ts`。
以下はプログラミングによる検証であり、本文の各等式・同値変形を個別のファイルへ対応させる。
上界、整除条件、小さい正の回数の証人、有限走査、有理数への入力、一セルの反例を扱う。

## 全数範囲と限界

- 有限集合は元数 $M=0,1,2,3,4$ の全自己写像を列挙する。空写像を含む 289 件。
- CA は空舞台の唯一の写像と、セル数 $L=1,2,3$ の周期境界付き全 256 初等規則を列挙する。合計 769 件。
  配位の列挙順から添字への全単射 `index` を作り、大域写像を添字の表へ移す。
  $L=1,2$ では三入力の参照先が重なるため、同じ大域写像を与える規則も別の規則入力として数える。
  これを 769 個の相異なる写像、または非一様な規則族の全数とは呼ばない。
- 上二群を合わせた 1,058 件について、$1\le n\le\max(1,2M)$ の 9,399 件の写像・回数入力を検査する。
  空集合では $n=1$ を検査し、周期表が空、個数が零、正値域への所属が偽であることを含む。
- 小さい回数の証人は、各元と全ての $0\le i<j\le M$ の衝突を列挙する。54,024 組の各証人で
  本文の五つの等号をそれぞれ検査する。小さい正の回数の非空性の同値自体は空集合も含む全入力で検査する。
- 一セル入れ替えは状態二通りの真理値表を全数検査し、帰納段階は $0\le k\le16$、個数は $1\le n\le34$ で照合する。
- 反復は直接適用で計算する。周期表は最初の再訪による計算と、本文の有限範囲の衝突走査を照合し、
  剰余による判定を直接反復の不動点数と比較する。期待値へ整除定理を代入しただけの比較にはしない。
- 計算は有限集合、整数、`ZZ`、`QQ` の厳密計算のみ。対数、浮動小数点、実数・複素数への脱出はない。
  有理数への写像は正の回数を確かめてから数え、零個を拒否して、正の個数だけを分母 1 の有理数へ渡す。
- 任意の有限集合・任意の規則・全ての回数に対する一般証明ではない。本文の帰納法を有限標本で証明済みとはしない。
  一般の命題は Lean 具体版・必要十分版と導出へ別途接続した（2026-09-06 01:12 tick）。
  熱力学の量そのものはまだ構成していない。

## 本文の各段との対応と実行結果

2026-09-06 01:12 tick に全39本を同じ条件で再実行し、全て終了コード0・下表と同じ結果を確認した。
今回の各ログは `/tmp/ca-tick-20260906-0112-<ファイル名>.log`。
Lean の二版・導出とプログラミングによる検証の結果は
[状態台帳](../../../docs/tasks/auto-loop-state.md)の同 tick 項を参照する。

2026-09-05 22:12 tick に全 39 本が終了コード 0。入力の非正回数を計数前に拒否する順序へ整えた後、
有理数入力の検算だけを追加の負入力 $-2$ とともに再実行し、終了コード 0 を確認した。
全数結果は `/tmp/ca-tick-20260905-2212-sage/results.json`、個別ログは同ディレクトリの各ファイル名、
有理数入力の最終ログは `positive-rational-final.log`。判定失敗・実行時エラーはなかった。

| ファイル | 対象ラベル | 式ペア・判定 | 状態 | 結果 |
| --- | --- | --- | --- | --- |
| `check_count_equals_fixed_set_cardinality.sage` | `claim_fixed_point_count_bounded_by_cardinality` | Z_n(F) = \|Fix_n(F)\| | PASS | map-exponent pairs checked: 9399 |
| `check_fixed_set_cardinality_bound.sage` | `claim_fixed_point_count_bounded_by_cardinality` | Fix_n(F) ⊆ X より 0 ≤ \|Fix_n(F)\| ≤ \|X\| | PASS | map-exponent pairs checked: 9399 |
| `check_domain_to_positive_count.sage` | `claim_positive_count_domain_iff_period_divides` | n ∈ Pos_F ⇔ Z_n(F)>0 | PASS | map-exponent pairs checked: 9399 |
| `check_positive_count_to_positive_cardinality.sage` | `claim_positive_count_domain_iff_period_divides` | Z_n(F)>0 ⇔ \|Fix_n(F)\|>0 | PASS | map-exponent pairs checked: 9399 |
| `check_positive_cardinality_to_witness.sage` | `claim_positive_count_domain_iff_period_divides` | \|Fix_n(F)\|>0 ⇔ ∃y∈Fix_n(F) | PASS | map-exponent pairs checked: 9399 |
| `check_fixed_witness_to_minimal_period.sage` | `claim_positive_count_domain_iff_period_divides` | ∃y∈Fix_n(F) ⇔ ∃y (μ(y)=0 ∧ ∃k∈N n=kπ(y)) | PASS | map-exponent pairs checked: 9399 |
| `check_zero_preperiod_to_periodic_witness.sage` | `claim_positive_count_domain_iff_period_divides` | μ(y)=0 を周期点所属へ置換 | PASS | map-exponent pairs checked: 9399 |
| `check_periodic_witness_to_realized_length.sage` | `claim_positive_count_domain_iff_period_divides` | 周期点の最小周期の存在 ⇔ Len_F の元の存在 | PASS | map-exponent pairs checked: 9399 |
| `check_natural_multiplier_to_positive_multiplier.sage` | `claim_positive_count_domain_iff_period_divides` | n>0 より乗数 k=0 を除ける | PASS | map-exponent pairs checked: 9399 |
| `check_zero_count_complement.sage` | `claim_positive_count_domain_iff_period_divides` | Z_n(F)=0 ⇔ 実現周期のいずれも n を割らない | PASS | map-exponent pairs checked: 9399 |
| `check_witness_substitution.sage` | `claim_positive_count_domain_small_witness` | F^p y = F^p(F^i x) | PASS | collision witnesses checked: 54024 |
| `check_witness_iterate_addition.sage` | `claim_positive_count_domain_small_witness` | F^p(F^i x) = F^(p+i)x | PASS | collision witnesses checked: 54024 |
| `check_witness_collision_index.sage` | `claim_positive_count_domain_small_witness` | F^(p+i)x = F^j x | PASS | collision witnesses checked: 54024 |
| `check_witness_collision_equality.sage` | `claim_positive_count_domain_small_witness` | F^j x = F^i x | PASS | collision witnesses checked: 54024 |
| `check_witness_return_to_y.sage` | `claim_positive_count_domain_small_witness` | F^i x = y | PASS | collision witnesses checked: 54024 |
| `check_small_witness_iff_nonempty.sage` | `claim_positive_count_domain_small_witness` | X≠∅ ⇔ Pos_F∩[1,\|X\|]_N≠∅、衝突証人の正値と上界 | PASS | maps checked: 1058 |
| `check_period_table_finite_scan.sage` | `claim_positive_count_domain_finitely_decidable` | 有限走査の μ,π から μ=0 の周期を重複除去し Len_F を復元 | PASS | maps checked: 1058 |
| `check_period_table_remainder_decision.sage` | `claim_positive_count_domain_finitely_decidable` | 周期表の剰余零判定 ⇔ 直接反復の正の不動点数 | PASS | map-exponent pairs checked: 9399 |
| `check_positive_rational_input.sage` | `def_positive_fixed_point_count_rational_input` | q_F(n)=Z_n(F)/1 ∈ QQ_{>0}、零個・非正回数は定義域外 | PASS | positive rational inputs: 8346 ; excluded inputs: 1056 |
| `check_binary_ca_count_bound.sage` | `claim_binary_ca_fixed_point_count_bound` | Z_n(F)≤\|A^V\|=2^\|V\| | PASS | CA-exponent pairs checked: 7170 |
| `check_binary_ca_domain_nonempty.sage` | `claim_binary_ca_positive_count_domain_nonempty` | Pos_F∩[1,2^\|V\|]_N≠∅（空舞台を含む） | PASS | CA maps checked: 769 / empty stage: one configuration, fixed at exponent 1 |
| `check_flip_global_definition.sage` | `claim_single_cell_flip_positive_count_domain` | (Gx_a)(v) = f_v(x_a\|{v}) | PASS | binary states checked: 2 |
| `check_flip_local_definition.sage` | `claim_single_cell_flip_positive_count_domain` | f_v(x_a\|{v}) = ν((x_a\|{v})(v)) | PASS | binary states checked: 2 |
| `check_flip_restriction_evaluation.sage` | `claim_single_cell_flip_positive_count_domain` | ν((x_a\|{v})(v)) = ν(x_a(v)) | PASS | binary states checked: 2 |
| `check_flip_configuration_evaluation.sage` | `claim_single_cell_flip_positive_count_domain` | ν(x_a(v)) = ν(a) | PASS | binary states checked: 2 |
| `check_flip_output_configuration.sage` | `claim_single_cell_flip_positive_count_domain` | ν(a) = x_{ν(a)}(v) | PASS | binary states checked: 2 |
| `check_flip_twice_recursion.sage` | `claim_single_cell_flip_positive_count_domain` | G²x_a = G(Gx_a) | PASS | binary states checked: 2 |
| `check_flip_twice_first_substitution.sage` | `claim_single_cell_flip_positive_count_domain` | G(Gx_a) = Gx_{ν(a)} | PASS | binary states checked: 2 |
| `check_flip_twice_second_substitution.sage` | `claim_single_cell_flip_positive_count_domain` | Gx_{ν(a)} = x_{ν(ν(a))} | PASS | binary states checked: 2 |
| `check_flip_negation_involution.sage` | `claim_single_cell_flip_positive_count_domain` | x_{ν(ν(a))} = x_a | PASS | binary states checked: 2 |
| `check_flip_even_index.sage` | `claim_single_cell_flip_positive_count_domain` | G^{2(k+1)}x_a = G^{2+2k}x_a | PASS | state-index pairs checked: 34 |
| `check_flip_even_composition.sage` | `claim_single_cell_flip_positive_count_domain` | G^{2+2k}x_a = G²(G^{2k}x_a) | PASS | state-index pairs checked: 34 |
| `check_flip_even_induction_substitution.sage` | `claim_single_cell_flip_positive_count_domain` | G²(G^{2k}x_a) = G²x_a | PASS | state-index pairs checked: 34 |
| `check_flip_even_return.sage` | `claim_single_cell_flip_positive_count_domain` | G²x_a = x_a | PASS | state-index pairs checked: 34 |
| `check_flip_odd_recursion.sage` | `claim_single_cell_flip_positive_count_domain` | G^{2k+1}x_a = G(G^{2k}x_a) | PASS | state-index pairs checked: 34 |
| `check_flip_odd_even_substitution.sage` | `claim_single_cell_flip_positive_count_domain` | G(G^{2k}x_a) = Gx_a | PASS | state-index pairs checked: 34 |
| `check_flip_odd_output.sage` | `claim_single_cell_flip_positive_count_domain` | Gx_a = x_{ν(a)} | PASS | state-index pairs checked: 34 |
| `check_flip_odd_nonfixed.sage` | `claim_single_cell_flip_positive_count_domain` | x_{ν(a)}≠x_a | PASS | binary states checked: 2 |
| `check_flip_zero_count_domain.sage` | `claim_single_cell_flip_positive_count_domain` | Z_{2k+1}=0、Z_{2k+2}=2、Pos_G は正の偶数回（有限範囲） | PASS | flip exponents checked: 1..34; odd count 0, even count 2 |

## 再実行

リポジトリのルートで実行する。途中失敗を成功にせず、その終了コードで止める。

```bash
set -e
for file in cellular-automata-statistical-mechanics/sagemath/check/positive-fixed-point-count-domain/check_*.sage; do
  sage "$file"
done
```

LLMによる検証では、前 tick の二本文と参照先の周期点・最小周期・反復の定義を読み、
各ファイルが表の式ペアまたは文章中の判定を担うことを照合した。二章の分類と各節の入力・出力・主張は維持する。
この読解判断と、上の再現可能な有限計算の成否を区別する。
