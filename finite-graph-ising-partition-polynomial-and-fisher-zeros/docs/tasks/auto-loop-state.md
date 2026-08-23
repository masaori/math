# 自動 tick 状態台帳

## 現在地

- 有限双曲曲面プロジェクトから移設した一般有限グラフ本文の独立性を再確認し、双曲曲面固有の数学ラベルへの依存が無いこと、移設時の 51 ラベルと 32 件の SageMath 検算対応、HTML/PDF 生成を確認した。
- 双曲曲面側の 21 個の参照出現は、この正本から必要な定義・主張の推移的依存閉包を取り込む接続層で維持した。
- 一般有限グラフについて、重複度込み Fisher 零点積が符号付きの定数項と最高次係数の比に等しい定理を追加した。現在は本文 52 ラベル、対応 SageMath 検算 33 件である。
- 上の零点積定理と両端係数の正値性から、一般有限グラフの全ての Fisher 零点が非零である定理を追加した。現在は本文 53 ラベル、対応 SageMath 検算 34 件である。
- Fisher 零点の非零性と零点積定理から、辺をもつ一般有限グラフの重複度込み Fisher 零点の逆数和が、負の一次係数と定数項の比に等しい定理を追加した。現在は本文 54 ラベル、対応 SageMath 検算 35 件である。
- 辺をもつ一般有限グラフについて、重複度込み Fisher 零点和が、負の最高次の一つ下の係数と最高次係数の比に等しい定理を追加した。現在は本文 55 ラベル、対応 SageMath 検算 36 件である。
- 一般有限グラフについて、重複度込み Fisher 零点の任意次数の基本対称式が、符号付きの対応高次係数と最高次係数の比に等しい定理を追加した。現在は本文 56 ラベル、対応 SageMath 検算 37 件である。
- 一般有限グラフについて、非零な Fisher 零点の逆数族の任意次数の基本対称式が、符号付きの対応低次係数と定数項の比に等しい定理を追加した。現在は本文 57 ラベル、対応 SageMath 検算 38 件である。
- 次数二以上の一般有限グラフについて、重複度込み Fisher 零点の二乗和が、最高次側三係数の有理式に等しい定理を追加した。現在は本文 58 ラベル、対応 SageMath 検算 39 件である。
- Fisher 零点の逆数和と低次係数比の既存証明について、構成した配位がスピン配位集合に属することを示す一行を補い、選んだ破れ辺から正次数を得る対応 SageMath 検算を追加した。本文ラベル数と検算対応件数は変わらない。
- 次数二以上の一般有限グラフについて、重複度込み Fisher 零点逆数の二乗和が、低次三係数の有理式に等しい定理を追加した。現在は本文 59 ラベル、対応 SageMath 検算 40 件である。
- 次数三以上の一般有限グラフについて、重複度込み Fisher 零点の三乗和が、最高次側四係数の有理式に等しい定理を追加した。現在は本文 60 ラベル、対応 SageMath 検算 41 件である。
- 次数三以上の一般有限グラフについて、重複度込み Fisher 零点逆数の三乗和が、低次側四係数の有理式に等しい定理を追加した。現在は本文 61 ラベル、対応 SageMath 検算 42 件、個別検算 165 本である。
- 次数四以上の一般有限グラフについて、重複度込み Fisher 零点の四乗和が、最高次側五係数の有理式に等しい定理を追加した。現在は本文 62 ラベル、対応 SageMath 検算 43 件、個別検算 178 本である。
- 次数四以上の一般有限グラフについて、重複度込み Fisher 零点逆数の四乗和が、低次側五係数の有理式に等しい定理を追加した。現在は本文 63 ラベル、対応 SageMath 検算 44 件、個別検算 190 本である。
- 一般有限グラフについて、重複度込み Fisher 零点の任意次数の冪和を、それ以前の冪和と高次係数から再帰的に決める Newton 漸化式を追加した。現在は本文 64 ラベル、対応 SageMath 検算 45 件、個別検算 194 本である。
- 一般有限グラフについて、重複度込み Fisher 零点逆数の任意次数の冪和を、それ以前の逆数冪和と低次係数から再帰的に決める Newton 漸化式を追加した。現在は本文 65 ラベル、対応 SageMath 検算 46 件、個別検算 200 本である。変更前レビューでは既存 195 本を全て個別実行して PASS した。
- Fisher 零点逆数冪和の Newton 漸化式が本文では分配多項式の次数以下に限られていたため、次数を超える全ての正整数次数へ低次係数漸化式を延長した。本文 65 ラベル、対応 SageMath 検算 46 件、個別検算 200 本のままで、既存 200 本と変更した 5 本を厳密演算で PASS した。
- 一般有限グラフについて、重複度込み Fisher 零点の一との差の積が、全スピン配位数と最高次係数の比 `2^{|V|}/Omega_G(d)` に等しい定理を追加した。現在は本文 66 ラベル、対応 SageMath 検算 47 件、個別検算 203 本である。変更前レビューでは既存 199 本の `check_*.sage` を全て個別実行して PASS した。
- 一般有限グラフについて、重複度込み Fisher 零点と任意の正有理評価点 `q` との差の積が、分配多項式の評価値と最高次係数の比 `Z_G(q)/Omega_G(d)` に等しい定理を追加した。現在は本文 67 ラベル、対応 SageMath 検算 48 件、個別検算 205 本である。変更前レビューでは既存 202 本の `check_*.sage` を全て個別実行して PASS した。
- 一般有限グラフについて、重複度込み Fisher 零点と任意の有理評価点 `q` との差の積が、分配多項式の評価値と最高次係数の比 `Z_G(q)/Omega_G(d)` に等しい定理を追加した。現在は本文 68 ラベル、対応 SageMath 検算 49 件、個別検算 208 本である。変更前レビューでは既存 205 本の `check_*.sage` を全て個別実行して PASS した。
- Fisher 零点と有理評価点との差の積の既存定理をレビューし、有理数 `q` と有理係数比を代数的数として無名に同一視していたため、`Q` から `Qbar` への標準単射をステートメントと証明の各式へ明記した。本文 68 ラベル、対応 SageMath 検算 49 件、個別検算 208 本のままであり、既存 208 本を全て個別実行して PASS した。Lean 具体版と必要十分版は未着手。
- Fisher 零点と正有理評価点との差の積の既存定理にも、有理数 `q`、自然数の最高次係数、代数的数の Fisher 零点の無名の同一視が残っていたため、`N` から `Q`、`Q` から `Qbar` への標準単射をステートメントと証明の各式へ明記した。一般有理評価点の定理へ依存させ、正値性だけを `Q` 内で証明する形に改めた。本文 68 ラベル、対応 SageMath 検算 49 件、個別検算 208 本のままであり、変更前レビューでは既存 208 本を全て個別実行して PASS した。変更した 3 本も厳密演算で PASS した。Lean 具体版と必要十分版は未着手。
- 一般有限グラフについて、重複度込み Fisher 零点と任意の代数的評価点との差の積が、`Qbar` 上で評価した分配多項式と最高次係数の比に等しい定理を追加した。現在は本文 69 ラベル、対応 SageMath 検算 50 件、個別検算 211 本である。変更前レビューでは既存 208 本を全て個別実行して PASS した。Lean 具体版と必要十分版は未着手。
- 一般有限グラフについて、二つの代数的評価点における重複度込み Fisher 零点差積の商が、最高次係数を含まない分配多項式の評価値比に等しい定理を追加した。現在は本文 70 ラベル、対応 SageMath 検算 51 件、個別検算 214 本である。変更前レビューでは既存 211 本を全て個別実行して PASS した。Lean 具体版と必要十分版は未着手。
- 二つの代数的評価点における Fisher 零点差積の商の既存証明をレビューし、分母積の係数比等式と非零性の導出が一行に束ねられていたため、一ステップ一定理に従って二行へ分離した。本文 70 ラベル、対応 SageMath 検算 51 件、個別検算 214 本のままであり、変更前レビューでは既存 214 本を全て個別実行して PASS した。Lean 具体版と必要十分版は未着手。
- 一般有限グラフの今後の研究はこの台帳だけで管理する。Lean 具体版と必要十分版は未着手。

## 実行待ち

| 作業 | 依存 | 状態 | 完了条件 |
| --- | --- | --- | --- |
| なし | — | — | 次の研究対象は、一般有限グラフで意味をもつ Fisher 零点の有限算術データから別途選定する |

## 完了

- 移設後の一般有限グラフ本文の独立性レビュー: 51 ラベル、32 件の検算対応、接続層、HTML/PDF を再確認し、欠陥なし。
- 一般有限グラフの Fisher 零点積と両端係数比: `theorem_fisher_zero_product_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の非零性: `theorem_fisher_zeros_nonzero` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の逆数和と低次係数比: `theorem_fisher_zero_reciprocal_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の逆数和と低次係数比の記述レビュー: 構成配位の所属を明示し、正次数を与える配位の検算を追加済み。
- 一般有限グラフの Fisher 零点和と高次係数比: `theorem_fisher_zero_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の基本対称式と係数比: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点逆数族の基本対称式と係数比: `theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の二乗和と係数比: `theorem_fisher_zero_square_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点逆数の二乗和と係数比: `theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の三乗和と係数比: `theorem_fisher_zero_cube_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点逆数の三乗和と係数比: `theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の四乗和と係数比: `theorem_fisher_zero_fourth_power_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点逆数の四乗和と係数比: `theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点冪和の Newton 漸化式と係数比: `theorem_fisher_zero_power_sum_newton_recurrence` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点逆数冪和の Newton 漸化式と係数比: `theorem_reciprocal_fisher_zero_power_sum_newton_recurrence` を次数を超える全ての正整数次数まで証明し、対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点の一との差の積と全配位数: `theorem_fisher_zero_shifted_product_configuration_count` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点と正有理評価点との差の積: `theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点と有理評価点との差の積: `theorem_fisher_zero_rational_shifted_product_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの Fisher 零点と有理評価点との差の積の記述レビュー: `Q` から `Qbar` への標準単射を明記し、無名の同一視を除去済み。
- 一般有限グラフの Fisher 零点と正有理評価点との差の積の記述レビュー: `N` から `Q`、`Q` から `Qbar` への標準単射を明記し、無名の同一視を除去済み。
- 一般有限グラフの Fisher 零点と代数的評価点との差の積: `theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio` と対応 SageMath 検算を追加済み。
- 一般有限グラフの二つの代数的評価点における Fisher 零点差積の商: `theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient` と対応 SageMath 検算を追加済み。
- 一般有限グラフの二つの代数的評価点における Fisher 零点差積の商の記述レビュー: 分母積の係数比等式と非零性の導出を二行に分け、一ステップ一定理へ適合済み。

## 判断の固定事項

- 一般有限グラフの新規成果はこのプロジェクトの正本へ書く。
- Fisher 零点そのものは `Qbar`、数値描画・距離・集積は `C` への脱出として分離する。
- 一 tick は一つの定義・主張・定理だけを前進させる。
