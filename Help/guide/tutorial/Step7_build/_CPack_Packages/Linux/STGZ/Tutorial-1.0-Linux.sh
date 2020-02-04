#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step7...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� #�9^ �\t[ŕI��$�Q~1���JBE�e'����(�;���@	Y?��-��Sp�M�օF�4n���m}��Ͳt��҅��uKJ�m�vrJwO���@O��P!�{��H�F�9��t���c�w��s���{�s���אw9y<����
RH2�o]����[���)����@��w�0L�L�)�DB�N�L�r��������HƂ��Vӏ]��'����_W�%���2HL���1��͖����J�od�X]�L#YGf����R
|� '�)������˭��L/$Fj�s��<^c��(�rh�S8u�b����%�rvV�f���,Q���唷���u1\�����j����zl!�G��#��>�JɛO.F;X}V�R���S>k�c=�5�����xzh�к��>w*ᮥ6�����T���0�W�>��'7FG���mw��E�k���.&�qC�6�aZ8Z�<]���L��7 _n�?M��?o3Ǜ,������g��f{�-�,�Y���E�+-�z�,�]J��2��-�/�����.�oX��B���˿z���>E/���CJ�V��5�@T�w W�梩*Q[���p$鍥�H����?�t{�#z�yε;:�-!�f�7e�u�DJ�	�"��xL�����}KGg�S�c�CC�`$�Jă�1m��ۣ�^����!��[*b!�.����:5�7�L�Z2�RP#������oulﬃ\۩�"�p�����:]i�F�-]j�G�w6��f4[4���UYtj�U������DZSQ5��F�x=��sc���%a5��MD���O���V���M�*/�A}�!�bx���7���@�`:������%jw��X<�vDR`6f��4��Q�ݨF��~����ՠ��yj$��'��D(��q��������
�\��dks�Z����;�6��^w��ڲ	X�}⵻֫�j-π�Z7>��a���n_B�~Uwo���>P�q���%���H�����߻gJ���<lP���y#����x�x���V~�5=���L}Ύw�����ɀ�p�[�U��)���f���~��2��*v�Ĉ�1����:uI8az�#���:�{�C�~$�%~\��������I_(�Y_$��^#�S~���X;�X���M|�[,��LO)<c`
�]��\|�)����^.�}>K�|��	��]^!���R�G�J�G�Z��|����~��/��<�X8����
	�2��s�Ï�%��� �.����K�
�>,2q2�;�8d�)��<�q�&�)��q
O�O��ǩ;1F�g��!���/�ǡ��G�G͝�����!����#�C7�N��"�C6�H�o!�C5��=��M(��2�84.�߅<���g�ǡ��<��m�GGx�yגy��@����]���������)��[��-�e�X�t3�l�a݁��W��
d~��]�m�����r'��꥟��w�^/�P�
��vvV���#���d�Hvc��h���Z(��V�B+}�6d��^�p�\��F{*6<\�Z���G�A��a�}XQ��5	��i4��{w �	�\�M������w۪=���H� ��BcNa-z#��}���e����Ftf�i�������[�y����o��0�d���������F��{���+�O�r����q~��+��tn�����>=���kx�Ly�`�}�5��s?L����V� �@�GA��.x,��)*E��������v��g_��<F�;ic~�e|�7�P m������k�J^�A�ت|;�η�V~��{�-�UЁ�j_X��&{A��P�o�U����R��Ю�8`.�2{Oe�S�{O�ҵ�;���T[	-Y��B�.�x5�������X���r#�QE?�b?�a�~&Z^���哞�FNa���͓���9���|�Jי"�n�b�d;:�MEe�%���e\Y0��*��^~��-�iW���x�SH��l�C�\�ԃ���+���`�aܺ2mc��~�)�A9엶� F�&֓���� ��NW��X��װ��Q�S˵����-��G���Y\�0:�O�ketN����W�Ѐ�'�����cD���Fx8���@�1c��d�N�l�(���Ӻ�Q�����O[��b}�P�o��O��E�/�.<�k�1>���D�����j��Dr^N\V筛dW�ʇp�T��$?���:�?��W��.�;+a�}�U>�^������o���Ќ��o�N;���;���Eć��8��Џp1�&��X�f;��̂�Ы6P{ݏ��+�����s^D���z]���2�`��٨�O���_M����?�ڏ���W�j�������/�mȷ��9�6����Eۄ;�7~�3.�(��}St��Clg%]�ߚ�/��S��p�i��骖̓M�Mp��dw9���hgS捖�+�+C�E������	��w��}��oͼ֚yes��M��
���W�y|V�Ю��v5]ߤ)���Q�lC�f����?����2�R��t��������=�$��(����Ɉ�~_%��XJ)</u�"�R�PW����T�'UX	ƕ��������(�910����(M2mP�'�Nn��ōw}�C�?��v��
���3��Wr��A��C�����=���eT�O^�o� �h�=@����:��'���a��e�On�<�_u�a��5�������br�.�(+���G�$ظ��M��R&?�r.G}(U�-U5۪��T��l\|�eu/���G����X�:�{&x+�XU�[�͕���P��7�����\��Kf)��~��}X	m+�����?�p8�y=���/��K�zzh6��������H!�T��.1���6����U WR+ٱ̖����c�bh��|~?����b~{���!�K0G�؄|�F+��{�z�Z�O!�)s�8F/B����T�:d�TU�i��J9X��j���@����@պᲶ��dպ�*OSՊMU
ȁ���r:�}�i���^.g;��/B��;�s�Q��	���;6�5{K߭v��t'3i&ͤ��'���~;����Q��v#?�x��)g���,��}cܟx�/��¸��߿�=��ӹ�QV������Y>�Y�c�C����>?L�Ǹ����޻�5�w�-r����F\�e�����5^�E�(��>�N3~�	���d��,�Uƿ[w ~�+�6�[���(�����;�{F��裌>��o}��R6�1�^љx�;O�&7|��{�{e������;���T�����8�k[��C�u4>���W?z���Ѻ���JY-�\����˕�=鸖Vֺ}n�jo�rޏz׹=>�w����*<Xg7����v#� �)^�__Fܙ_WF�4���xY~^���|6���ƈ�ί/#>'���
����c2_��5����}ˈ�Ȥ)>7�`���"3|>9\c�/��F|a~_4�Lץv'��q��d�;��\#�������ONƱ��П�RV1�~	_�p���ZZ��dd����z]�LO��g�/��Q��F�]�
��4����d��Y�W��g�s��U>-�ۦ�׳м��Z�[��X�E6��q^��x��a�<�U�yh&���TO�<R�E�d�<.�P=���q��'PC��y;ω����/����]���vlUa]�3��v]���/ex�"�����*j���g%�GOZ�Y������Q��\>l����@?�����R�/��~l��-�EN�]|��>�)�%��!���M�@��|��g�_N�U|_��D�Oy�.1�c���~�S�o����|2�̈/q���~<ⴈwr�zd;�1=0��Sj��S��� ��-��P�y\���Z��2{N2{�c��z�¬V��_Xf����L�������B��i\S��������������I(���t4��B����!�kJU'���DO�_k�dJ��H(10��"a�چ�kͅ0`%����5ג{H4������("p*:`��qv���h�N�w�`,��KE�P"�Ғ鐦g�S�XU ���-R�W7v3��Q�������bD��z妦V(��Q[�`��=���+6f#�"��-Mm~տc3F��[wt�� �;����Mm-͐gh[���|5Wn����R��6��բ0��F1\G���Z|����Oc�R�=l	�C��~�Gm�ҥ�o����u����Zc�0$j�s=��������.=>��J����t*>�5�رwk����d����m�����J�}0�h��bԤ�o7T�����v'#Q�iĠI&�^++D'7�A_,ᢨ�����r��
Vb^W[3_b<x�,t�&i2�pY�u����G���Fl^�ډ�����Z�7	�%�ɂq�������O)w]O*��T����;���T�l����"=�Ji�a(�V��d*66
q��KI�t���I(ǢŸTK�𦃒�`����W�[��)/Tc�1P5�4���z���_6ZDܩ=Z�(l?���+���A�'����j-��8��ݓ���W�r}�Tq���A�N����[?�50*�%#�AdW��V	S/ݽ	��}���N&����c}�d����
E5�����۴��_C���X.�BX���C���=`���~f|��ϝV���d���c���"ɗH�W*��n�^|��x��J.���nT*��p�{m�}߼<��q��Q��ۄ��-p1����}���sIq�]Ot�5/����6H��%z#�}����<%������H����9��y��x�?��ob<�Gr�O(�I�O�����b*!�㟑�s�&�.��]�C*������U.ѿ���ߋc��b�51�:c��T��8�ݾr����/��pz���<}S*o�>�U�?��s.�C�_\��1�<��r�R����SDw��eVx?M�e��<~�=�����8�s{��/c~��?�O�?�r|��6��k+����3�J*���02$�W$���xy��b�5R����lz��1/�J���MM�N�aV�0[ 8��Έ��lS;sDl�P�?s-��թ�����S,�O�#��7 �����������"��oj}[�q��J���j�>�4�_����S_[뫇��y=3����N�1�Uw��`���+L��g�_`���9��z��p��_��
�������5̬�s�֬�a�!:��d$�$�=@	��J*�a�zJ�&�
�"���Dc�HP��wt�\�Cmk�ve��F�ex�ݝ~�횶����~��I��������<������ǿ�٭���Z��V��q��9p��O�$-{0����5�1y��=���so���G�O8�.�	G��Ěi��4���zk�v�U6��*9���F���T���J!�.�R�8�J!r���d�5}�N������+�,�M�R�K��W
ui�W
M��^)�et��1Al�X̬�o��1�usź	V�Z����ӹz�/_�[��z�=j�t�ꍯ��|�7��c�fo|Y%��KL����G�Gd���a����k��^��x�b�G��H�(��Y�zͿ��(��s����Q�w�5A�[Y���1��V�~���F�O0�a��c�?c�/���n|��n+x�Ŵ�B>m���U ���L��y��;�����Ė�#`�OR�~p��d�q1�;Rz�1�C���Gdn��.>��W����}*�'���<�2���#��? ���${x}�Ix��N��2�B�E�����_)��#��_�\g���Bϵ6����b�|^��D��(�/�	��	��z�-�S#����/���#��*¸��H���}�	�z�-�zt���C<h����3����;�WӠ3&��9;I!�d��O��#@�/��4�N�w
o0�E@��H'��.Vn��K�����'~r,�+�^b~���J�|g� 1� 󔵛��'��y�e�-���_))�m���Q�}.��v�S����d��y�)��|�,�G����?�[� ��V'����A��?��L�[� ���3��`�rLJ�_�	�L�I3�5�/�@[ b  