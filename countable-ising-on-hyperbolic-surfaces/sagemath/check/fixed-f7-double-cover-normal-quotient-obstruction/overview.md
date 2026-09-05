# 固定二枚被覆の正規商入力への不適合

**対象ラベル**: `def_two_stage_finite_quotient_tower_input`

併用する本文の定義は `def_quotient_tower_role_generator_compatibility`、
`def_quotient_tower_induced_coset_cell_maps`、
`def_finite_quotient_oriented_coset_edge_endpoint_data`、
`def_finite_quotient_oriented_coset_face_boundary_word`、
`def_primal_first_coboundary_space`。
これは指定された被覆一つの入力適合判定であり、新規一般定理ではない。

## 判定対象

基底・被覆はそれぞれ `../fixed-f7-matrix-cellulation/certificate.json` と
`../fixed-f7-double-cover/certificate.json`。全バイトの SHA-256 を今回の証明書へ保存する。
役割別セルの整数符号、固定辺向き、二枚のシートの符号化は両証明書をそのまま使う。
以下のシート計算は符号を二元体へ送った後の演算である。

基底の符号行列商を \(Q\)、指定行列 \(A\) の像を \(a\in Q\) とする。
左乗算 \(L_a:Q\to Q,\ g\mapsto ag\) が各役割の左剰余類へ誘導する全単射を

\[
\alpha_R:Q/H_R\longrightarrow Q/H_R,\qquad gH_R\longmapsto agH_R
\quad(R\in\{V,E,F\})
\]

とする。群元一覧から全セル上の写像を生成し、辺端点と面境界語を照合する。
辺の固定向きが反転する場合は向きラベルを反転し、面の開始位置の巡回移動も明示する。

## 持ち上げに必要な有限方程式

基底の頂点・辺符号集合を \(V,E\)、選択済みコサイクルを \(c\in\mathbb F_2^E\)、
基底の二元体一次境界行列を \(d_1\in\mathbb F_2^{V\times E}\) とする。
各頂点ファイバーが二元なので、\(\alpha_V\) を覆う任意の頂点全単射は、一つの
\(t\in\mathbb F_2^V\) により \((v,s)\mapsto(\alpha_V(v),s+t_v)\) と書ける。
基底辺 \(e:u\to v\) の二端を保つためには、全 \(s\in\mathbb F_2\) に対して

\[
s+c_e+t_v=s+t_u+c_{\alpha_E(e)}
\quad\Longleftrightarrow\quad
t_u+t_v=c_e+c_{\alpha_E(e)}
\]

が必要である。像辺の固定向きの反転は、この二元体の端点差を変えない。
したがって必要条件は
\(d_1^{\mathsf T}t=c+\alpha_E^*c\)、ただし
\((\alpha_E^*c)_e:=c_{\alpha_E(e)}\) である。

証明書の辺順において

\[
\operatorname{supp}(z)=\{0,6,49,55,74,76,78,80,81,82,83\}\subseteq E
\]

をもつ二元体辺ベクトル \(z\in\mathbb F_2^E\) は
\(d_1z=0\)、\(\langle c,z\rangle=1\)、\(\langle\alpha_E^*c,z\rangle=0\) を満たす。
もし必要方程式の解 \(t\) があれば、

\[
1=\langle c+\alpha_E^*c,z\rangle
 =\langle d_1^{\mathsf T}t,z\rangle
 =\langle t,d_1z\rangle=0
\]

となり矛盾する。各等号は順に保存したペアリング、必要方程式の代入、行列転置の公式、
保存した零境界による。この固定基底自己同型は被覆へ持ち上がらない。

## 本文の商の塔を適用できない理由

本文の正規商入力と役割生成元整合性で、この被覆とその射影が実現できると仮定する。
段間全射群準同型を \(\kappa:Q_{\mathrm{fine}}\to Q\) とすれば、
\(\kappa(\widetilde a)=a\) を満たす \(\widetilde a\in Q_{\mathrm{fine}}\) が存在する。
細段剰余類への左乗算 \(gH_R^{\mathrm{fine}}\mapsto\widetilde a gH_R^{\mathrm{fine}}\)
は全単射であり、逆は \(\widetilde a^{-1}\) の左乗算である。
端点の二つの代表 \(g,gr_E^{\mathrm{fine}}\) は
\(\widetilde a g,\widetilde a gr_E^{\mathrm{fine}}\) へ移り、端点接続を保つ。
面位置の右乗算とも結合律で可換なので、面境界も保つ。
さらに全役割で

\[
\kappa(\widetilde a g)H_R
 =\kappa(\widetilde a)\kappa(g)H_R
 =a\kappa(g)H_R
\]

となる（順に群準同型性と \(\widetilde a\) の選択）。これは上で排除した持ち上げであり矛盾する。
したがって、固定基底との対応・役割生成元・射影を保つ正規商の塔への適合は否定される。
抽象的な群の商を二つ置けるかだけを判定した結果ではない。

## プログラミングによる検証

実行日: 2026-09-06。

本文一括検査の初回起動はリポジトリ直下で `npm run gen` を指定し、
同位置に `package.json` が無いため ENOENT・終了コード254となった。
runbook が指定する当プロジェクトの `structured-latex/` へ作業ディレクトリを直し、
同じ生成・一括検査・PDF生成の経路で再実行して全て成功した。
検算対応246件と今回の証明書の完全再現も成功した。

| ファイル | 判定内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_certificate.sage` | 基底左作用、全セル写像、持ち上げの必要方程式と不整合の証人 | PASS | 係数行列の階数23、拡大行列の階数24、サイクルへのペアリング1と0。正規商入力を棄却 |

基底・被覆の既存判定も再実行し、両証明書の完全一致を確認した。
新しい判定は `GF(7)` と `GF(2)` の厳密演算だけを使う。
`certificate.json` は基底全作用、全セル写像、面開始位置の移動、三コサイクル、
障害サイクルを保存し、再実行時には全バイトの一致を要求する。

## LLMによる検証と終了範囲

本文の商・剰余類セル・端点・面境界の定義と生成コードを照合した。
全射商から全基底左作用が持ち上がる必要性と、二元ファイバーでの端点方程式を上記の通り確認した。
連結二枚被覆である既存成果は維持するが、指定された正規商の塔としては候補を閉じる。
runbook の否定時の終了条件により、依存する二段のホモロジー類・分配多項式の比較は非適用とする。
別の被覆、型、入力群は選ばない。保存性・非保存性や零点極限の結論は得ていない。
Lean具体版・必要十分版は未着手。

リポジトリ直下で実行する。

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-f7-double-cover-normal-quotient-obstruction/check_certificate.sage
```
