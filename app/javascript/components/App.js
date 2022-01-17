import React, {useState} from "react"
import PropTypes from "prop-types"
import {Appbar, Container, Input, Panel, Button} from 'muicss/react';
import {nanoid} from "nanoid";

class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = {numbers: [], ssr: false}
    }
    addNumber = function () {
        this.setState({
            ...this.state,
            numbers: [...this.state.numbers, {id: nanoid(), value: "0"}]
        })
    }.bind(this)
    setNumber = function (index, value) {
        //if (isNaN(value.value)) { return }
        //value.value = value.value.trim().replace(/^0+/, '') || '0'
        this.state.numbers.splice(index, 1, value)
        this.setState({
            ...this.state,
            numbers: this.state.numbers
        })
    }.bind(this)
    deleteNumber = function (index) {
        this.state.numbers.splice(index, 1)
        this.setState({
            ...this.state,
            numbers: this.state.numbers
        })
    }.bind(this)
    fetchLongestChunk = async function () {
        location.href = `/chunks/index?q=${this.state.numbers.map(number => number.value).join(',')}&ssr=${this.state.ssr}`
    }.bind(this)
    toggleSSR = function () {
        this.setState({
            ...this.state,
            ssr: !this.state.ssr
        })
    }.bind(this)
    render() {
        const disabled = this.state.numbers.length === 0 ||
            this.state.numbers.some(value => isNaN(value.value) || isNaN(parseFloat(value.value)))
        return (
            <React.Fragment>
                <Appbar>
                    <Container>
                        <div className="mui--text-display1">
                            <div className="mui--appbar-line-height ">ЛР 10</div>
                        </div>
                    </Container>
                </Appbar>
                <Container>
                    <Panel style={{display: "flex", flexDirection: "column", alignItems: "center"}}>
                        <div>
                            <Button onClick={this.addNumber}>Добавить</Button>
                            <Button color="primary" onClick={this.fetchLongestChunk} disabled={disabled}>Отправить</Button>
                            <Button color="text" onClick={this.toggleSSR}>
                                Сервер <span style={{background: "lightgray", borderRadius: "50em"}}>{!this.state.ssr?"🔵  ":"  🔵"}</span>
                            </Button>
                        </div>
                        {this.state.numbers.map((number, index) => <div key={number.id} style={{display: "flex", flexWrap: "wrap"}}>
                            <Input placeholder="Введите значение" type="number" value={number.value} onChange={e => this.setNumber(index, {id: number.id, value: e.target.value})}/>
                            <Button color="danger" style={{marginLeft: "20px", marginTop: "15px"}} onClick={() => this.deleteNumber(index)}>Удалить</Button>
                        </div>)}
                    </Panel>
                </Container>
            </React.Fragment>
        );
    }
}

export default App
