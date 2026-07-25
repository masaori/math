#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$Z, Y$ は $"Mat"(2, CC)^(times.o M)$ を環として生成する])[
  #ref(<def_transfer_matrix_symbols>)（004 章冒頭の記号の定義）で定義された
  $Z_1, dots.c, Z_M, Y_1, dots.c, Y_M in "Mat"(2, CC)^(times.o M)$ について、集合
  $
    S := { Z_1, dots.c, Z_M, Y_1, dots.c, Y_M }
  $
  を考える。ここで $"Mat"(2, CC)^(times.o M)$ を $CC$ 上の単位的結合多元環
  （積と $CC$-線型結合について閉じ、単位元 $I_(("Mat"(2, CC))^(times.o M))$ を含む）とみなす。

  このとき、$S$ を含む最小の $CC$-部分多元環（$S$ の各元、単位元、それらの積、$CC$-線型結合をすべて含み、積と線型結合について閉じる最小の部分集合。これを $cal(A)$ とおく）は $"Mat"(2, CC)^(times.o M)$ 全体に一致する。すなわち
  $
    cal(A) = "Mat"(2, CC)^(times.o M)
  $

  #proof[
    以下、$sigma^x, sigma^y, sigma^z in "Mat"(2, CC)$ を標準的な Pauli 行列
    $
      sigma^x =
      mat(
        0, 1;
        1, 0
      ),
      quad
      sigma^y =
      mat(
        0, -sqrt(-1);
        sqrt(-1), 0
      ),
      quad
      sigma^z =
      mat(
        1, 0;
        0, -1
      )
    $
    とする。$sigma_k^x, sigma_k^y, sigma_k^z in "Mat"(2, CC)^(times.o M)$
    は #ref(<def_transfer_matrix_symbols>) のとおり、第 $k$ テンソル因子のみが対応する Pauli 行列で、他の因子はすべて $I_("Mat"(2, CC))$ であるものとする。

    === Step 1: 単一サイトの Pauli 行列の積公式

    $"Mat"(2, CC)$ の元の積を成分計算すると、次が成り立つ。
    $
      sigma^x sigma^x
      =
      mat(
        0, 1;
        1, 0
      )
      mat(
        0, 1;
        1, 0
      )
      =
      mat(
        1, 0;
        0, 1
      )
      =
      I_("Mat"(2, CC))
      quad (because "行列の積の成分計算")
    $

    $
      sigma^y sigma^z
      =
      mat(
        0, -sqrt(-1);
        sqrt(-1), 0
      )
      mat(
        1, 0;
        0, -1
      )
      =
      mat(
        0, sqrt(-1);
        sqrt(-1), 0
      )
      =
      sqrt(-1)
      mat(
        0, 1;
        1, 0
      )
      =
      sqrt(-1) sigma^x
      quad (because "行列の積の成分計算")
    $

    特に、第 2 式の両辺に $-sqrt(-1)$ を掛けると
    $
      sigma^x
      =
      - sqrt(-1) sigma^y sigma^z
      quad (because (sqrt(-1))^(-1) = - sqrt(-1))
    $
    を得る。

    これらをテンソル積に持ち上げる。$"Mat"(2, CC)^(times.o M)$ の元の積は各テンソル因子ごとの積であり、
    $
      (A_1 times.o dots.c times.o A_M)(B_1 times.o dots.c times.o B_M)
      =
      (A_1 B_1) times.o dots.c times.o (A_M B_M)
      quad (because "テンソル積上の積の定義")
    $
    が成り立つ（各 $A_j, B_j in "Mat"(2, CC)$）。

    第 $k$ 因子のみが非自明な $sigma_k^a$ どうしの積を考える。$a, b in {x, y, z}$、$k in {1, dots.c, M}$ について
    $
      sigma_k^a sigma_k^b
      &=
      (I times.o dots.c times.o overbrace(sigma^a, k"th") times.o dots.c times.o I)
      (I times.o dots.c times.o overbrace(sigma^b, k"th") times.o dots.c times.o I)
      \
      &=
      (I I) times.o dots.c times.o overbrace((sigma^a sigma^b), k"th") times.o dots.c times.o (I I)
      quad (because "テンソル積上の積の定義")
      \
      &=
      I times.o dots.c times.o overbrace((sigma^a sigma^b), k"th") times.o dots.c times.o I
      quad (because I I = I)
    $
    が成り立つ（ここで $I := I_("Mat"(2, CC))$ と略記した）。

    これより、Step 1 の単一サイトの積公式 $sigma^x sigma^x = I_("Mat"(2, CC))$ および $sigma^x = - sqrt(-1) sigma^y sigma^z$ を $k$ 番目因子に適用すると
    $
      sigma_k^x sigma_k^x
      =
      I_(("Mat"(2, CC))^(times.o M))
      quad (because sigma^x sigma^x = I_("Mat"(2, CC)))
    $
    $
      sigma_k^x
      =
      - sqrt(-1) sigma_k^y sigma_k^z
      quad (because sigma^x = - sqrt(-1) sigma^y sigma^z)
    $
    を得る。

    また、異なるサイト $k != l$ の $sigma_k^a, sigma_l^b$ は可換である。実際 $k < l$ とすると
    $
      sigma_k^a sigma_l^b
      &=
      (I times.o dots.c times.o overbrace(sigma^a, k"th") times.o dots.c times.o I)
      (I times.o dots.c times.o overbrace(sigma^b, l"th") times.o dots.c times.o I)
      \
      &=
      I times.o dots.c times.o overbrace(sigma^a, k"th") times.o dots.c times.o overbrace(sigma^b, l"th") times.o dots.c times.o I
      quad (because "テンソル積上の積の定義")
      \
      &=
      (I times.o dots.c times.o overbrace(sigma^b, l"th") times.o dots.c times.o I)
      (I times.o dots.c times.o overbrace(sigma^a, k"th") times.o dots.c times.o I)
      quad (because "テンソル積上の積の定義")
      \
      &=
      sigma_l^b sigma_k^a
    $
    が成り立つ（$k > l$ の場合も同様に左右を入れ替えて成り立つ）。

    === Step 2: $cal(A)$ が各 $sigma_k^x, sigma_k^y, sigma_k^z$ を含むこと

    各 $m in {1, dots.c, M}$ について $sigma_m^x, sigma_m^y, sigma_m^z in cal(A)$ であることを、
    「$sigma_1^x, dots.c, sigma_(m-1)^x in cal(A)$」を仮定とする $m$ に関する帰納法で示す。

    まず $m = 1$ のとき、定義より $Z_1 = sigma_1^z$、$Y_1 = sigma_1^y$ であるから、
    $
      sigma_1^z = Z_1 in cal(A)
      quad (because Z_1 = sigma_1^z)
    $
    $
      sigma_1^y = Y_1 in cal(A)
      quad (because Y_1 = sigma_1^y)
    $
    である。さらに Step 1 の積公式（$k = 1$）より
    $
      sigma_1^x
      =
      - sqrt(-1) sigma_1^y sigma_1^z
      =
      - sqrt(-1) Y_1 Z_1
      in cal(A)
      quad (because cal(A) "は積と" CC"-線型結合について閉じる")
    $
    を得る。よって $sigma_1^x, sigma_1^y, sigma_1^z in cal(A)$。

    次に $m >= 2$ とし、帰納法の仮定として $sigma_1^x, dots.c, sigma_(m-1)^x in cal(A)$ を仮定する。
    $
      P_(m-1) := sigma_1^x sigma_2^x dots.c sigma_(m-1)^x
    $
    とおくと、$cal(A)$ は積について閉じるから $P_(m-1) in cal(A)$ である
    （$m = 1$ のときは空積とみなし $P_0 := I_(("Mat"(2, CC))^(times.o M)) in cal(A)$）。

    $P_(m-1)$ は冪等の逆元をもつ。実際、異なるサイトの可換性（Step 1）と
    $sigma_k^x sigma_k^x = I_(("Mat"(2, CC))^(times.o M))$ より
    $
      P_(m-1) P_(m-1)
      &=
      (sigma_1^x dots.c sigma_(m-1)^x)(sigma_1^x dots.c sigma_(m-1)^x)
      \
      &=
      (sigma_1^x sigma_1^x)(sigma_2^x sigma_2^x) dots.c (sigma_(m-1)^x sigma_(m-1)^x)
      quad (because "異サイトの可換性")
      \
      &=
      I_(("Mat"(2, CC))^(times.o M))
      quad (because sigma_k^x sigma_k^x = I_(("Mat"(2, CC))^(times.o M)))
    $
    が成り立つ。ゆえに $P_(m-1)$ は可逆で $P_(m-1)^(-1) = P_(m-1) in cal(A)$ である。

    定義より $Z_m = sigma_1^x dots.c sigma_(m-1)^x sigma_m^z = P_(m-1) sigma_m^z$ であるから、左から $P_(m-1)$ を掛けると
    $
      P_(m-1) Z_m
      &=
      P_(m-1) P_(m-1) sigma_m^z
      quad (because Z_m = P_(m-1) sigma_m^z)
      \
      &=
      I_(("Mat"(2, CC))^(times.o M)) sigma_m^z
      quad (because P_(m-1) P_(m-1) = I_(("Mat"(2, CC))^(times.o M)))
      \
      &=
      sigma_m^z
    $
    を得る。$P_(m-1) in cal(A)$ かつ $Z_m in cal(A)$、$cal(A)$ は積について閉じるから
    $
      sigma_m^z = P_(m-1) Z_m in cal(A)
      quad (because cal(A) "は積について閉じる")
    $
    である。同様に $Y_m = P_(m-1) sigma_m^y$ より
    $
      P_(m-1) Y_m
      &=
      P_(m-1) P_(m-1) sigma_m^y
      quad (because Y_m = P_(m-1) sigma_m^y)
      \
      &=
      I_(("Mat"(2, CC))^(times.o M)) sigma_m^y
      quad (because P_(m-1) P_(m-1) = I_(("Mat"(2, CC))^(times.o M)))
      \
      &=
      sigma_m^y
    $
    であり、
    $
      sigma_m^y = P_(m-1) Y_m in cal(A)
      quad (because cal(A) "は積について閉じる")
    $
    を得る。さらに Step 1 の積公式（$k = m$）より
    $
      sigma_m^x
      =
      - sqrt(-1) sigma_m^y sigma_m^z
      in cal(A)
      quad (because cal(A) "は積と" CC"-線型結合について閉じる")
    $
    である。よって $sigma_m^x, sigma_m^y, sigma_m^z in cal(A)$ が示され、帰納法の仮定が $m$ まで延長された。

    以上の帰納法により、すべての $k in {1, dots.c, M}$ について
    $sigma_k^x, sigma_k^y, sigma_k^z in cal(A)$ が成り立つ。

    === Step 3: $cal(A) = "Mat"(2, CC)^(times.o M)$

    まず、$"Mat"(2, CC)$ において
    $
      cal(B) := { I_("Mat"(2, CC)), sigma^x, sigma^y, sigma^z }
    $
    は $CC$ 上の基底である。実際、任意の
    $
      A
      =
      mat(
        a_(11), a_(12);
        a_(21), a_(22)
      )
      in "Mat"(2, CC)
    $
    に対し、成分を比較すると
    $
      A
      =
      (
        (a_(11) + a_(22)) / 2
      )
      I_("Mat"(2, CC))
      +
      (
        (a_(12) + a_(21)) / 2
      )
      sigma^x
      +
      (
        sqrt(-1) (a_(12) - a_(21)) / 2
      )
      sigma^y
      +
      (
        (a_(11) - a_(22)) / 2
      )
      sigma^z
      quad (because "成分比較")
    $
    が成り立つので $cal(B)$ は $"Mat"(2, CC)$ を張る。
    また $dim_(CC) "Mat"(2, CC) = 4 = \# cal(B)$ であり、張る 4 元集合が 4 次元空間を張るならそれは基底であるから、$cal(B)$ は $"Mat"(2, CC)$ の基底である。

    次に、$cal(B)$ の元のテンソル積からなる集合
    $
      cal(B)^(times.o M)
      :=
      { e_1 times.o dots.c times.o e_M : e_1, dots.c, e_M in cal(B) }
    $
    は $"Mat"(2, CC)^(times.o M)$ の基底である
    $
      quad (because #ref(<tensor_basis>))
    $

    一方、$cal(B)^(times.o M)$ の各元 $e_1 times.o dots.c times.o e_M$（各 $e_k in cal(B)$）は $cal(A)$ に属する。実際、各 $k$ について
    $
      sigma_k^(a_k) := I times.o dots.c times.o overbrace(e_k, k"th") times.o dots.c times.o I
    $
    （$e_k$ が $I_("Mat"(2, CC))$ なら $sigma_k^(a_k) = I_(("Mat"(2, CC))^(times.o M))$、そうでなければ $e_k in {sigma^x, sigma^y, sigma^z}$ に応じて $sigma_k^x, sigma_k^y, sigma_k^z$ のいずれか）とおくと、Step 1 の異サイト因子の積公式を繰り返し用いて
    $
      sigma_1^(a_1) sigma_2^(a_2) dots.c sigma_M^(a_M)
      =
      e_1 times.o e_2 times.o dots.c times.o e_M
      quad (because "テンソル積上の積の定義")
    $
    が成り立つ。Step 2 より各 $sigma_k^(a_k) in cal(A)$（$I_(("Mat"(2, CC))^(times.o M)) in cal(A)$ も含む）であり、$cal(A)$ は積について閉じるから
    $
      e_1 times.o dots.c times.o e_M
      =
      sigma_1^(a_1) dots.c sigma_M^(a_M)
      in cal(A)
      quad (because cal(A) "は積について閉じる")
    $
    である。よって $cal(B)^(times.o M) subset.eq cal(A)$。

    $cal(A)$ は $CC$-線型結合について閉じるから、$cal(B)^(times.o M)$ の $CC$-線型結合はすべて $cal(A)$ に属する。$cal(B)^(times.o M)$ は $"Mat"(2, CC)^(times.o M)$ の基底（上記）であり、基底の $CC$-線型結合全体は空間全体に一致するから
    $
      "Mat"(2, CC)^(times.o M)
      =
      "span"_(CC) (cal(B)^(times.o M))
      subset.eq
      cal(A)
      quad (because cal(A) "は" CC"-線型結合について閉じる")
    $
    である。一方、$cal(A) subset.eq "Mat"(2, CC)^(times.o M)$ は定義より明らかであるから
    $
      cal(A) = "Mat"(2, CC)^(times.o M)
    $
    が成り立つ。

    $qed$
  ]
]<Z_Y_generate_algebra>
