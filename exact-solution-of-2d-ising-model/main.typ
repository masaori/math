
#import "@preview/cetz:0.1.2"
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge
#import "theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#set page(width: 60cm, height: auto)
#set block(breakable: false)
#show: theorem_rules.with(qed-symbol: $square$)

#let mapDef(f, A, B, a, b, comment) = {
  $
  #grid(
    columns: 6,
    gutter: 5pt,
    $#f$, $:$, $#A$, $->$, $#B$, $#comment$,
    "", "", rotate(-90deg, $in$), "", rotate(-90deg, $in$), "",
    "", "", $#a$, $|->$, $#b$,  ""
  )
  $
}

== 計算公式
#include "parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ"
#include "parts/000_計算公式/001_definition_非負実数のsqrt.typ"
#include "parts/000_計算公式/002_theorem_負数からsqrtへの変換.typ"
#include "parts/000_計算公式/003_theorem_行列の分解.typ"
#include "parts/000_計算公式/004_theorem_行列の組みへの作用.typ"
#include "parts/000_計算公式/005_theorem_行列の共役.typ"
#include "parts/000_計算公式/006_definition_CCの定義.typ"
#include "parts/000_計算公式/007_definition_RRからCCへの包含写像.typ"
#include "parts/000_計算公式/008_definition_マイナス1倍.typ"
#include "parts/000_計算公式/009_definition_sqrt_minus_1.typ"
#include "parts/000_計算公式/010_definition_CCの実部虚部.typ"
#include "parts/000_計算公式/011_definition_単位円.typ"
#include "parts/000_計算公式/012_definition_円弧の定義.typ"
#include "parts/000_計算公式/013_definition_CCからC_unitへの写像.typ"
#include "parts/000_計算公式/014_definition_CCの逆三角関数の定義.typ"
#include "parts/000_計算公式/015_claim_cos_arctan_sin_arctan.typ"
#include "parts/000_計算公式/016_definition_角度表現の同値類.typ"
#include "parts/000_計算公式/017_definition_角度表現の切断.typ"
#include "parts/000_計算公式/018_definition_RRの角度表現.typ"
#include "parts/000_計算公式/019_definition_極座標表現の同値類.typ"
#include "parts/000_計算公式/020_remark_極座標表現の同値類の性質.typ"
#include "parts/000_計算公式/021_definition_極座標表現の演算.typ"
#include "parts/000_計算公式/022_claim_極座標表現の乗法群.typ"
#include "parts/000_計算公式/023_claim_CCの乗法群.typ"
#include "parts/000_計算公式/024_claim_CCは体をなす.typ"
#include "parts/000_計算公式/025_claim_極座標表現は体をなす.typ"
#include "parts/000_計算公式/026_definition_極座標表現のCCへの写像_phi_polar.typ"
#include "parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ"
#include "parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ"
#include "parts/000_計算公式/029_definition_第1座標と第2座標_pr1_pr2.typ"
#include "parts/000_計算公式/030_definition_絶対値と偏角_abs_arg.typ"
#include "parts/000_計算公式/031_claim_複素数の積のarg.typ"
#include "parts/000_計算公式/032_claim_複素数の商のarg.typ"
#include "parts/000_計算公式/033_claim_複素数の積のargがpiのときのarg同士の関係.typ"
#include "parts/000_計算公式/034_claim_CCの自乗のarg.typ"
#include "parts/000_計算公式/035_claim_CCの逆数のarg.typ"
#include "parts/000_計算公式/036_note_arg計算のコツ_極座標表現を使った偏角の計算方法.typ"
#include "parts/000_計算公式/037_definition_CCのsqrt_複素数の平方根の定義.typ"
#include "parts/000_計算公式/038_claim_CCのsqrtの極座標表現による展開.typ"
#include "parts/000_計算公式/039_claim_sqrtと積が可換になる条件_argの範囲による場合分け.typ"
#include "parts/000_計算公式/040_claim_sqrtの2乗は元に戻る.typ"
#include "parts/000_計算公式/041_claim_自乗のsqrtとremark_負の実数の場合.typ"
#include "parts/000_計算公式/042_claim_CCの逆数のsqrtとremark.typ"
#include "parts/000_計算公式/043_claim_CCのsqrtの逆数とremark.typ"
#include "parts/000_計算公式/044_theorem_cos_sinのEuler表示.typ"
#include "parts/000_計算公式/045_claim_共役写像は環準同型.typ"
#include "parts/000_計算公式/046_claim_交換子と反交換子の関係.typ"

== 2次元ising模型の分配関数

#include "parts/001_2次元ising模型の分配関数/000_definition_格子サイズ.typ"
#include "parts/001_2次元ising模型の分配関数/001_definition_2次元ising模型の分配関数.typ"
#include "parts/001_2次元ising模型の分配関数/002_definition_転送行列.typ"
#include "parts/001_2次元ising模型の分配関数/003_claim_転送行列による分配関数の表式.typ"

== 線型空間の一般論

#include "parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ"
#include "parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ"
#include "parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ"
#include "parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ"

== 線型写像のexp

#include "parts/003_線型写像のexp/000_theorem_線型写像のexpの級数が各点収束すること.typ"
#include "parts/003_線型写像のexp/001_definition_有限次元線型空間の自己準同型のexpの定義.typ"
#include "parts/003_線型写像のexp/002_theorem_可換行列のexpの積公式.typ"
#include "parts/003_線型写像のexp/003_theorem_零行列のexpはI.typ"

= 対角化の計算 (ホロノミック量子場 付録B)

#definition("記号の定義")[
  - $I_("Mat"(2, CC))$: $"Mat"(2, CC)$上の単位行列
  - $sigma_k^x := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^x,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
  - $sigma_k^y := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^y,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
  - $sigma_k^z := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^z,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
  - $I_(("Mat"(2, CC))^(times.o M))$ := $I_("Mat"(2, CC)) times.o dots.c times.o I_("Mat"(2, CC))$
  - $V_1 := exp (sqrt(-1) K_1 dot.op (sigma_1^z sigma_2^z + sigma_2^z sigma_3^z + dots.c + sigma_M^z sigma_1^z)) in "Mat"(2, CC)^(times.o M)$
  - $V_2 := (2 sinh 2K_2)^(M/2) exp (K_2^* dot.op (sigma_1^x + sigma_2^x + dots.c + sigma_M^x)) in "Mat"(2, CC)^(times.o M)$

  - $Z_m := sigma_1^x dots.c sigma_(m-1)^x sigma_m^z in "Mat"(2, CC)^(times.o M) quad "ただし、" Z_1 := sigma_1^z quad ("ホロノミック量子場では" p_m)$

  正し、$Z_(M+1) := Z_1$

  - $Y_m := sigma_1^x dots.c sigma_(m-1)^x sigma_m^y in "Mat"(2, CC)^(times.o M) quad "ただし、" Y_1 := sigma_1^y quad ("ホロノミック量子場では" q_m)$

  正し、$Y_(M+1) := Y_1$

  - $epsilon := sigma_1^x dots.c sigma_M^x = (sqrt(-1))^M Z_1 Y_1 + dots.c + Z_M Y_M in "Mat"(2, CC)^(times.o M)$

  - $K_1^* := -1/2 log(tanh K_1) arrow.l.r sinh(K_1) sinh(K_1^*) = 1$
  - $K_2^* := -1/2 log(tanh K_2) arrow.l.r sinh(K_2) sinh(K_2^*) = 1$
  - $c_i := cosh 2K_i, quad s_i := sinh 2K_i,$
  - $c_i^* := cosh 2K_i^*, quad s_i^* := sinh 2K_i^*$

  $K_i, K_i^* > 0$ より、 $c_i, s_i, c_i^*, s_i^* > 0$
]

== 転送行列

#include "parts/004_転送行列/000_definition_転送行列の記号の定義.typ"
#include "parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ"
#include "parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ"
#include "parts/004_転送行列/003_definition_epsilonの固有空間.typ"
#include "parts/004_転送行列/004_definition_EndFとMat2Cテンソル積Mの同型.typ"
#include "parts/004_転送行列/005_claim_V1の固有空間への制限.typ"
#include "parts/004_転送行列/006_definition_V1_plus_minusの定義.typ"
#include "parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ"
#include "parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ"
#include "parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ"
#include "parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ"
#include "parts/004_転送行列/011_claim_H1_H2をZhat_Yhatで表す.typ"
#include "parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ"
#include "parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ"
#include "parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ"

== $e^(X) Y e^(-X) = e^("ad"(X))(Y)$ の証明

#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/000_リー群リー環アプローチの概要とAd_adの定義.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/002_式変形アプローチの概要と行列空間の内積ノルム収束の定義.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003_theorem_ad展開の二項定理的公式_BrianHall_exercise14.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/004_definition_一般線型群GL(n,CC)とその群構造.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/005_definition_Matrix_Lie群の定義.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/006_definition_Matrix_Lie群上のAd_gとad_Xの定義.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/007_theorem_exp(ad_X)(Y)の級数展開_BrianHall_Prop3.35.typ"
#include "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/008_theorem_exp(X)Yexp(-X)=Ad(exp(X))(Y)=exp(ad_X)(Y)_BrianHall_Prop3.35.typ"

== $Z$と$Y$の反交換関係

#include "parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ"

== $hat(Z)$と$hat(Y)$の反交換関係

#include "parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ"

== $T_(V_(1))(hat(Z))$と$hat(Z),hat(Y)$の関係

#include "parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/002_claim_cosh_sinhの展開係数への変換.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/005_claim_exp_X_Y_exp_minus_X.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/006_definition_自己同型群_内部自己同型群_外部自己同型群.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/007_definition_自己同型群の完全列.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/009_definition_TODO_クリフォード群.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/011_claim_ホロノミック量子場_p142下段.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/012_definition_T_V1_T_V2の直積写像.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/013_claim_T_V1_T_V2のhatZ_hatYへの直積作用の計算.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/015_definition_T_V.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/016_definition_A_theta.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/017_claim_T_VのhatZ_hatYへの作用.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/036_claim_A_thetaの行列分解.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/018_definition_theta_mu.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/019_definition_A_thetaの対角化の準備.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/020_claim_gamma1_gamma2の偏角.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/021_claim_gamma2_thetaが0になる条件.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/022_claim_gamma2_thetaとgamma2_minus_thetaの関係.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/023_claim_gamma2_theta_muの積のarg.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/024_claim_gamma2_theta_mu_gamma2_minus_theta_muのarg.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/026_claim_A_thetaの対角化_固有値と固有ベクトル.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/027_claim_A_thetaの対角化_P_muとD_mu.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/030_claim_Vとpsiの交換関係.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/034_claim_det_A_theta_mu.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/035_claim_gamma1_geq_1.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/041_claim_T_VprimeのhatZ_hatYへの作用_gamma2が0の場合.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/042_claim_T_VとT_VprimeはhatZ_hatY上で一致.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ"
#include "parts/008_T_V1_hatZとhatZ_hatYの関係/040_claim_gamma2_thetaMの周期性.typ"

(次回 0531)
- $gamma_(theta_mu)$を求める
    - (B.13)の関係式からexpの指数としてでてくるのでは？
    - 出てこんかった
    - (次回 20250614)
      - 固有ベクトルが間違えている？ので再度チェック
      - $v
      &= 
      c
      mat(
        plus.minus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        );
        sqrt(
          -1
        )
        gamma_2(-theta_(mu))
      )$ こうなってくれると都合が良い
以下の数値計算による
```sagemath
i = I

M = 8
mu = 1
nu = -1
c1 = 1.0
c2 = 2.0
s1 = 0.5
s2_star = 1.0

theta_mu = 2 * pi * mu / M
theta_nu = 2 * pi * nu / M

a = i * exp(i * theta_mu) * s2_star * (c1 * cos(theta_mu) - i * sin(theta_mu) - s1 * c2)
b = i * exp(i * theta_nu) * s2_star * (c1 * cos(theta_nu) - i * sin(theta_nu) - s1 * c2)

ab = a * b

ab_real = ab.real()
ab_imag = ab.imag()

is_real = abs(ab_imag.n()) < 1e-10 # 許容誤差
is_nonneg = ab_real.n() >= 0

# 偏角の取得
arg_a = arg(a)
arg_b = arg(b)
arg_ab = arg(a) + arg(b)

print(f"a = {a.n()}")
print(f"b = {b.n()}")
print(f"ab = {ab.n()}")
print(f"ab の実部: {ab_real.n()}, 虚部: {ab_imag.n()}")
print(f"ab は実数か? {is_real}")
print(f"ab は非負か? {is_nonneg}")
print(f"arg(a) = {arg_a.n()}")
print(f"arg(b) = {arg_b.n()}")
print(f"arg_ab = {arg_ab.n()}")
print(f"2pi = {(2 + pi).n()}")
```

- こうすると$g' = V'$が本の表式通り定義できる
     - この時に $Psi$の係数Mが消えたりして嬉しいのでは？
- $T_(V)$と$T_(V')$が同じことを示す (B.13/14から示せるらしい)

(次回 0510)
- 対角化まで終わった
- いまのところ、$g^prime = exp(-sum_mu gamma_mu (psi_mu^dagger psi_mu - 1/2))$ これが見つかる理由が全然わからん


(次回 0403)
P.「したがって 転送行列 の 対角化は,各 μ ごとに 4行 4列 の 行列 ス (θ″ )① ス (― =0,π (し )自 身 θ μ のと きはス )を 対角化する問題 に 帰着 された 。」これを正当化しなくても計算は進むか？

- A(theta)の固有ベクトルが (B.11/12)で天下りてきに与えられているので固有値は簡単に求まる
- その組み合わせ(多分)で Vの固有値が命題2.4で与えられているので、これが本当に固有値かはチェック可能？
  - むずいかもなので、命題2.4で与えられている固有値に属する固有ベクトルをなんらか求めたい
  - 本にはヒントなさそうなので自分でひねりだす
  - これが捻り出せたら、結局Pを正当化する必要はない
- 計算めんどそうなところ
  - ガンマの定義から、e^(gamma)を計算するところが?になりそう？
  - Vの固有ベクトルを捻り出すところ
      - A(theta)の固有ベクトルの組み合わせを色々試す？
      - なんか一般論がないか文献当たってみる

(次回0313-3)
- ホロノミック　付録 B の計算を続ける
    - 付録A(Clifford群の一般論)を眺めないといけないかも
    - 大変そうだったら色々認めて進める
  - $T_(V)$と$V$がほぼ1:1対応している？
    - 具体的な変換規則を知りたい
  - 変換規則がわかれば、$T_(V)$の対角化によって$V$の対角化ができる(?)
  - 


- ↑の @ホロノミック量子場_p142下段_1 のproofを続ける
- Lie Groups, Lie Algebras, and RepresentationsのProposition 3.35.の証明の概略はたどりたい
  - 続き
  - 公式の意味は定まったので、計算は進みそう
      - Lie群であることはどこで使われるか？(収束性の話)
- 文献管理 Bibliography https://typst.app/docs/reference/model/bibliography/ やってみる


= 全体のノリ
- 分配関数を行列環の元のtraceに対応させる $<-$ この元の固有値を求めたい
- その元が、行列環の「群をなす部分集合(かつ次元の低い部分空間の中にある)」の元だとわかると、リー群 リー環の対応によって計算が進む
- なので、行列環とクリフォード代数の同型が見つけたい
  - かつ、分配関数がクリフォード群の元のtraceに対応するとわかりたい


= メモ

二つの代数系の変換が関わっている
- logをとる ($RR$の同型)
    - 組み合わせ数(乗法的) -> エントロピー(加法的)
    - 分配関数のボルツマン因子(ハミルトニアンのexp)はこれによって出てくる
      - expなので逆変換
      - ハミルトニアン(=エネルギー)はエントロピー的な概念ということ
    - 分配関数は確率の規格化定数であり、仮説として「ある状態が出てくる確率は対応するボルツマン因子の値に比例する」がある
      - ボルツマン因子は組み合わせ数的な概念になっているので、組み合わせ数に確率が比例するは至極自然
      - 分配関数自体は、系の統計量である自由エネルギーなどに変換可能なので物理的に美味い

- 離散フーリエ変換 (?)
    - 畳み込み和 -> 積
    - ボルツマン因子の指数部分がもう畳み込み和みたいな形になっている
        - 二重和なので、そこを剥がす必要があるということかも
    - 巡回行列は離散フーリエ変換をすると対角化可能　らしい
        - https://ja.wikipedia.org/wiki/%E5%B7%A1%E5%9B%9E%E8%A1%8C%E5%88%97
    - 転送行列 $V$ の固有値問題に帰着させるのがOnasgerの戦略
        - $V = V_1 V_2$ の分解 → 各因子をスピン演算子で表現 → Lie環の構造を利用して対角化
