let data = {
};

const getMaterias = async id => {
    await fetch(`http://localhost:8083/SGI_war_exploded/GetMateriaS?id=${id}`,{
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        }
    }).then(response => response.json()).then(response =>{
        data = response;
        console.log(data);
    }).catch(error =>{
        console.log(error);
    });
}

const materiasEstado = async id => {
    await getMaterias(id);
    document.getElementById('ch_id').value = data.id;
}

const materiasBorrado = async id => {
    await getMaterias(id);
    document.getElementById('d_id').value = data.id;
}