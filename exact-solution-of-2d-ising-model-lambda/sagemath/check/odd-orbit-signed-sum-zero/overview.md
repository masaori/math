# SageMath Check: 奇数軌道を持つ置換の符号付き和の相殺

**対象ラベル**: `claim_odd_orbit_signed_sum_zero`

- 本文: `structured-latex/content/main-text.ts`、ブロック `tools_claim_odd_orbit_signed_sum_zero` の証明29計算・判定行。
- 帰属: 有限置換集合、整数 `ZZ`、円分体 `CyclotomicField(8)` 上の多項式環。浮動小数点・実数体への脱出はない。
- 先行ブロックの反転・符号・反対称行列の構成は `../selected-odd-orbit-skew-product-neg/_prelude.sage` を使用する。

## 検算する標本

添字の個数が零から六までの全874置換を列挙し、自然順序と逆順序（添字が零個・一個の場合は重複させない）の1,746例から、不動点がなく奇数長の軌道を持つ172例を選ぶ。選択条件は無向グラフ探索で得た各軌道の長さから判定し、反転そのものは順反復から計算する。各順序と添字集合に密・零・疎の反対称行列を用意し、36行列群、516符号付き項を検査する。

閉集合は反転写像の軌道の和集合として構成する。空・全体、一軌道・二軌道、単一軌道の補集合、軌道列の前半・後半、偶数番目・奇数番目を含め、重複を除く。各閉集合のすべての σ を選び、その反転 τ と、二点を除いた R を計算する。重みや和が零かどうかで標本を選ばない。和は行列成分から計算した各項を加算し、対の相殺や帰納法の結論を計算に使わない。

空の添字集合、対象集合が空の四点集合、長さ三と二の軌道を持つ五点の置換、二つの長さ三の軌道を持つ六点の置換を含む。R が空の場合と空でない場合、符号付き項が非零の場合を統合検算で明示的に検査する。

背理法の仮定 F(ρ)=σ と ρ∈R は同時に満たせない。最初の背理法の三行は ρ=τ を使い、F(ρ)=σ を直接確認してから各等式を計算する。二つ目の背理法の四行は ρ=σ を使い、F(ρ)=τ を確認する。両方とも非空の局所標本であり、ρ∉R を毎回検査する。統合検算では R のすべての元に対して F(ρ)≠σ,τ も別途確認する。

## 行ごとの対応

表の順序が本文の順序である。背理法の行は上記の局所標本を検査し、帰納法の仮定の行は各標本の残り集合で和を直接計算する。

| ファイル | 本文の式・判定 | ステータス | 確認数 |
|---|---|---|---|
| `check_involution.sage` | F(F(ρ)) = ρ | PASS | 516 |
| `check_no_fixed_point.sage` | F(ρ) ≠ ρ | PASS | 516 |
| `check_term_negation.sage` | w_A(F(ρ)) = −w_A(ρ) | PASS | 516 |
| `check_empty_sum.sage` | Σ_{ρ∈∅} w_A(ρ) = 0 | PASS | 36 |
| `check_partner_membership.sage` | τ ∈ S | PASS | 30,732 |
| `check_partner_distinct.sage` | τ ≠ σ | PASS | 30,732 |
| `check_remainder_subset.sage` | R ⊆ S∖{σ} | PASS | 30,732 |
| `check_erase_strict_subset.sage` | S∖{σ} ⊊ S | PASS | 30,732 |
| `check_remainder_cardinality.sage` | ∣R∣ < ∣S∣ | PASS | 30,732 |
| `check_reversed_remainder_in_set.sage` | F(ρ) ∈ S (ρ∈R) | PASS | 656,448 |
| `check_first_contradiction_involution.sage` | ρ = F(F(ρ)) (F(ρ)=σ) | PASS | 30,732 |
| `check_first_contradiction_substitution.sage` | F(F(ρ)) = F(σ) (F(ρ)=σ) | PASS | 30,732 |
| `check_first_contradiction_partner.sage` | F(σ) = τ | PASS | 30,732 |
| `check_second_contradiction_involution.sage` | ρ = F(F(ρ)) (F(ρ)=τ) | PASS | 30,732 |
| `check_second_contradiction_substitution.sage` | F(F(ρ)) = F(τ) (F(ρ)=τ) | PASS | 30,732 |
| `check_second_contradiction_partner.sage` | F(τ) = F(F(σ)) | PASS | 30,732 |
| `check_second_contradiction_return.sage` | F(F(σ)) = σ | PASS | 30,732 |
| `check_remainder_closed.sage` | F(ρ) ∈ R (ρ∈R) | PASS | 656,448 |
| `check_remainder_sum.sage` | Σ_{ρ∈R} w_A(ρ) = 0 | PASS | 30,732 |
| `check_pair_partner_definition.sage` | w_A(σ)+w_A(τ) = w_A(σ)+w_A(F(σ)) | PASS | 30,732 |
| `check_pair_term_substitution.sage` | w_A(σ)+w_A(F(σ)) = w_A(σ)+(−w_A(σ)) | PASS | 30,732 |
| `check_pair_cancellation.sage` | w_A(σ)+(−w_A(σ)) = 0 | PASS | 30,732 |
| `check_sum_extract_first.sage` | Σ_S w_A = w_A(σ)+Σ_{S∖{σ}} w_A | PASS | 30,732 |
| `check_sum_extract_partner.sage` | w_A(σ)+Σ_{S∖{σ}} w_A = w_A(σ)+(w_A(τ)+Σ_R w_A) | PASS | 30,732 |
| `check_sum_associate.sage` | w_A(σ)+(w_A(τ)+Σ_R w_A) = (w_A(σ)+w_A(τ))+Σ_R w_A | PASS | 30,732 |
| `check_sum_cancel_pair.sage` | (w_A(σ)+w_A(τ))+Σ_R w_A = 0+Σ_R w_A | PASS | 30,732 |
| `check_sum_substitute_remainder.sage` | 0+Σ_R w_A = 0+0 | PASS | 30,732 |
| `check_sum_zero_add.sage` | 0+0 = 0 | PASS | 30,732 |
| `check_total_sum.sage` | Σ_D w_A = 0 | PASS | 36 |

2026-10-11 に29行すべて PASS、合計1,990,620確認。36行列群にわたる閉集合は3,516例、σの選択を含む二項削除は30,732例、残り集合の元は延べ656,448例。対象集合が空の行列群は18例、残り集合が空になる二項削除は516例だった。境界例と局所的な矛盾仮定の検査も通過した。

## 実行

```sh
sage exact-solution-of-2d-ising-model-lambda/sagemath/check/odd-orbit-signed-sum-zero/check.sage
```

各 `check_*.sage` も同じコマンドのファイル名を替えて個別に実行できる。統合 `check.sage` は29本を読み込み、件数と境界例も検査する。

実行環境は SageMath 10.9。有限標本の厳密検算であり、任意の有限集合に対する一般命題の証明ではない。一般の帰納法は本文と Lean が担う。

## 実行時の修正

2026-10-11 の初回実行は、SageMath の CLI が入力ファイルのパスを `__file__` に設定しないため、検算ファイルの列挙で ERROR となった。入力パス `sys.argv[0]` へのフォールバックを追加した。次の実行は29行の検算通過後、件数出力の Sage 整数の JSON 変換で ERROR となったため、表示時に整数へ変換する処理を加えた。数式・標本・比較条件は変更していない。
