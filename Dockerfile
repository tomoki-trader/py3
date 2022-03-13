#ベースイメージはできるだけ軽量にする。
FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel

ARG USERNAME=tomoki
ARG GROUPNAME=tomoki
#新しいID作成
ARG UID=1003
ARG GID=1004
ARG PASSWORD=tomoki
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 
#rootからユーザーに変更
USER $USERNAME

WORKDIR .
COPY ./config.txt ./working/ 
#COPYにカレントディレクトリ’.’が入っているほうが良い。（ADDも同様）
#copy先の書き方注意
WORKDIR ./working
#WEOKDIRの指定によって'.'の値が変更されている！！


#RUN apt-get update 

#RUN pip3 install --user -r ./config.txt -f https://download.pytorch.org/whl/cu115/torch_stable.html

RUN pip3 install ipywidgets 
RUN pip3 install jupyterlab 

#RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension 
#RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

COPY jupyter_notebook_config.py /root/.jupyter/

#heyhey 2