# SageMath 校正: 初等規則の状態数・対数・隣接差

**対象ラベル**: `claim_binary_ca_fiber_count_partition`

本文の [有限舞台の状態数から作る対数と隣接差](../../../structured-latex/content/binary-ca-logarithmic-counts.ts)
と [対数順序群内の整数除算](../../../structured-latex/content/prime-logarithm.ts) を、
有限巡回舞台の全初等規則へ接続するプログラミングによる検証である。
新しい一般命題の証明ではなく、四層を持つ既存の主張を指定した有限入力で校正する。

## 入力と量の定義域

- セル数は $L\in\{3,4,5,6\}$。セル集合は $V_L=\{0,\ldots,L-1\}$、
  左右への写像は整数を $L$ で割った余りへ戻す $v\mapsto(v\pm1)\bmod L$。
  近傍は左・自身・右の三元集合で、この範囲では重複しない。
- 配位 $x:V_L\to\{0,1\}$ を辞書式順に列挙する。番号への写像は
  $\operatorname{enc}_L(x)=\sum_{v=0}^{L-1}[x(v)=1]2^{L-1-v}$。
  逆写像はこの順に並べた配位表から番号で取り出す写像である。
- 規則は $r\in\{0,\ldots,255\}$ の全て。左・自身・右の値が $a,b,c$ のとき
  出力は $\lfloor r/2^{4a+2b+c}\rfloor\bmod2$。局所制限からの計算とビット演算を別に照合する。
- 反復回数は各大域写像について $1\le n\le2\cdot2^L$ の全て。
  全配位を一段ずつ反復した集合と、各配位の軌道を衝突まで追跡して得た周期の整除による集合を照合する。
- 整数値写像は $H_a(x)=a\,\#\{v:x(v)=1\}$、$a\in\{-2,-1,0,1,2\}$ の五つ。
  指示関数の自然数和を整数へ送ってから整数倍する。状態集合へ体や群の演算を加えない。
  各規則について全配位の $H_a(Fx)=H_a(x)$ を判定し、保存する入力だけを後続へ渡す。
  非保存の入力は証人を持つ棄却として数える。定数写像も元の定義どおり含める。
- 状態数は自然数、正の状態数の対数と両端が正の隣接差は素数上の有限台整数ベクトル。
  自由エントロピーは正の不動点総数だけで定義する。零の値を対数の代用品にしない。
- 異なる正値添字 $u,v$ の全ての順序対では、非零刻み $d=v-u$ による除算の定義域も照合する。
  全素数係数の整除と、状態数比の既約分子・分母が $|d|$ 乗の自然数であることを独立に計算する。
  負の刻みでは復元する比を逆数へ移す。除算不能は非整除の素数係数を証人にする。

## 全数範囲で得た結果

大域写像は1,024入力、整数値写像を合わせた5,120入力中、保存するものは1,120、
保存しないものは4,000。$H_1$ を保存する規則は次のとおりだった。

| セル数 | 状態1の個数を保存する規則 |
| --- | --- |
| 3 | 170, 172, 184, 202, 204, 216, 226, 228, 240 |
| 4, 5, 6（各サイズ） | 170, 184, 204, 226, 240 |

反復回数を含む大域写像の入力61,440組のうち、総数が零は4,656、正は56,784。
保存写像を含む入力66,496組について、正の繊維75,808個と、検査した零繊維149,728個を区別した。
後者の走査範囲は $H_a(A^{V_L})$ とその最小値の一つ下・最大値の一つ上に限る。
隣接差は4,600入力で定義され、片端が欠落する167,464入力を拒否した。
隣接候補は $H_a(A^{V_L})\cup\{u-1:u\in H_a(A^{V_L})\}$ である。
正の繊維の全順序対における整数除算は26,880入力で成立し、43,872入力で非整除となった。
これらは入力枝の実行件数であり、独立な数学的成果の件数ではない。

## 明示例と限界

三セルの恒等規則204と $H_1$、一回反復では、値0・1・2・3の状態数は1・3・3・1。
隣接差は順に $\ell_3,0_\Lambda,-\ell_3$、自由エントロピーは $3\ell_2$ となる。
同じ規則の $H_2$ では正値添字が0・2・4・6となり、隣接差の定義域は空である。
値0と2の対数差は $\ell_3$ なので、刻み2で割れない。ここで $\ell_p$ は素数 $p$ の係数だけが1のベクトル。

規則172は四セルの配位0011を0010へ写すため、状態1の個数が2から1へ減り保存条件に反する。

三セルの移動規則170と $H_1$ は、一回反復では値0・3の繊維だけを持ち隣接差が無いが、
三回反復では状態数1・3・3・1となる。同じ保存写像でも反復回数により隣接差の定義域が変わる。
三セルの反転規則51は、一回反復の総数が零で自由エントロピーが未定義、二回反復では総数8で $3\ell_2$。

これらの例は `check_recorded_examples.sage` が真理値表から再計算する有限データである。
任意のセル数や回数の定理へ昇格したとはしない。一般の場合の根拠は既存本文とLean二版・導出にある。
全整数値保存写像、非一様規則、他の舞台、無限舞台を全数検査したとはしない。
保存写像と整数刻みの選択に対する不変性、熱浴、重み付き分配関数、連続理論との対応も含まない。
全演算は有限集合・整数・有理数・素因数分解・厳密な整数根で閉じ、浮動小数点と実数複素数への評価は無い。

## 本文の各式との対応

各ファイルは独立に実行できる。共通定義 `_prelude.sage` は入力列挙を担当し、
対数の算術は既存 `logarithmic-counts/_prelude.sage` を読み込む。
繊維の総和は式ペアごと、隣接差は四つの式ペアごとに分け、最終式だけの一致で済ませない。

| ファイル | 対象ラベル | 式ペア・判定 | 実行結果 |
| --- | --- | --- | --- |
| `check_partition_multiplicity.sage` | `claim_binary_ca_fiber_count_partition` | Σ Ω = Σ \|C(u)\| | PASS: cases checked: 66496 |
| `check_partition_disjoint_union.sage` | `claim_binary_ca_fiber_count_partition` | Σ \|C(u)\| = \|union C(u)\| | PASS: cases checked: 66496 |
| `check_partition_cover.sage` | `claim_binary_ca_fiber_count_partition` | union C(u) = Fix_n(F) | PASS: cases checked: 66496 |
| `check_partition_fixed_count.sage` | `claim_binary_ca_fiber_count_partition` | \|Fix_n(F)\| = Z_n(F) (周期長による独立計数との照合は fixed_iteration) | PASS: cases checked: 66496 |
| `check_beta_definition.sage` | `claim_binary_ca_unit_difference_ratio` | β = S(u+1)-S(u) | PASS: cases checked: 4600 |
| `check_beta_entropy.sage` | `claim_binary_ca_unit_difference_ratio` | S(u+1)-S(u) = log(Ω(u+1)/1)-log(Ω(u)/1) | PASS: cases checked: 4600 |
| `check_beta_log_ratio.sage` | `claim_binary_ca_unit_difference_ratio` | log(hi/1)-log(lo/1) = log((hi/1)/(lo/1)) | PASS: cases checked: 4600 |
| `check_beta_rational_ratio.sage` | `claim_binary_ca_unit_difference_ratio` | log((hi/1)/(lo/1)) = log(hi/lo) | PASS: cases checked: 4600 |
| `check_free_definition.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | Φ = log(q_F(n)) | PASS: cases checked: 61840 |
| `check_free_rational_input.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | log(q_F(n)) = log(Z_n(F)/1) | PASS: cases checked: 61840 |
| `check_free_fiber_sum.sage` | `claim_binary_ca_logarithmic_free_count_fibers` | log(Z_n/1) = log(Σ Ω/1) | PASS: cases checked: 61840 |
| `check_local_conservation.sage` | `def_binary_ca_integer_conserved_observable` | 真理値表の局所制限と整数値写像の保存判定 | PASS: accepted: 1120 rejected: 4000 |
| `check_fixed_iteration.sage` | `claim_fixed_point_count_decomposition` | 直接反復の不動点集合と独立な軌道走査の周期整除を照合 | PASS: time inputs: 61440 zero: 4656 positive: 56784 |
| `check_entropy_domain.sage` | `def_binary_ca_fiber_logarithmic_entropy` | 有限像上の繊維と素因数指数の復元・零個入力の拒否 | PASS: inputs: 66496 positive fibers: 75808 zero fibers: 149728 |
| `check_beta_domain.sage` | `def_binary_ca_unit_logarithmic_difference` | 両端が正の隣接入力の受理と欠落入力の拒否 | PASS: adjacent: 4600 missing endpoint: 167464 empty domains: 65520 |
| `check_free_domain_bound.sage` | `claim_binary_ca_logarithmic_free_count_bound` | 正総数の Φ を復元し有理数上界と移送順序を照合、零総数を拒否 | PASS: positive: 56784 zero: 4656 |
| `check_integer_gap_division.sage` | `claim_prime_vector_integer_division` | 全ての正の繊維対の非零刻みについて全素数係数の整除と有理数冪を照合 | PASS: division accepted: 26880 rejected: 43872 |
| `check_recorded_examples.sage` | `def_binary_ca_fiber_logarithmic_entropy` | 上記六入力と保存条件のサイズ依存の証人 | PASS: 六入力と保存失敗の配位を再計算 |

LLMによる検証では、本文の入力条件、各式ペアの対応、保存条件での選別、周期走査と直接反復の違い、
正の対数入力と非整除の拒否を読んで照合した。表の件数だけを意味の一致の根拠にしない。
各スクリプトは `sage <このディレクトリ>/check_<対象名>.sage` で再実行する。
2026-09-06 06:12 tickの最終プログラミングによる検証では全18本が終了0・RESULT: PASS。
自由エントロピーの有理数入力への展開を別ファイルへ分けた後、全18本を同じ最終ソースで実行した。
各式ペアと入力枝の件数は上表と一致し、明示例も再計算された。
実行ログと集計は `/tmp/ca-tick-20260906-0612-sage-final/` に置く。
先行する16本の実行結果は `/tmp/ca-tick-20260906-0612-sage/` に保持する。失敗した検算は無い。
